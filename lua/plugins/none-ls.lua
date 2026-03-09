-- Personaliza as fontes do none-ls.

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- Referências úteis:
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    local null_ls = require "null-ls"
    local helpers = require "null-ls.helpers"
    local cmd_resolver = require "null-ls.helpers.command_resolver"
    local methods = require "null-ls.methods"
    local project_root = require "utils.project_root"
    local format_policy = require "utils.format_policy"
    local FORMATTING = methods.internal.FORMATTING
    local prettier_filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "json",
      "jsonc",
      "yaml",
      "markdown",
      "markdown.mdx",
      "css",
      "scss",
      "html",
    }
    local none_ls_markers = {
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
      "eslint.config.ts",
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.json",
      "tsconfig.json",
      "tsconfig.base.json",
      "package.json",
      "go.work",
      "go.mod",
      "pyproject.toml",
      "requirements.txt",
      ".sqlfluff",
      ".sqlfluff.toml",
      ".sqllsrc.json",
    }

    local eslint_d_format = helpers.make_builtin {
      name = "eslint_d",
      meta = {
        url = "https://github.com/mantoni/eslint_d.js/",
        description = "Executa eslint_d --fix-to-stdout quando o projeto usa ESLint como fonte de formatacao.",
      },
      method = FORMATTING,
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
      },
      generator_opts = {
        command = "eslint_d",
        args = {
          "--fix-to-stdout",
          "--stdin",
          "--stdin-filename",
          "$FILENAME",
        },
        dynamic_command = cmd_resolver.from_node_modules(),
        cwd = function(params)
          local filetype = vim.bo[params.bufnr].filetype
          local decision = format_policy.get_decision(params.bufname, filetype)
          return decision and decision.root or params.root
        end,
        to_stdin = true,
        check_exit_code = function(code) return code <= 1 end,
        runtime_condition = function(params)
          local filetype = vim.bo[params.bufnr].filetype
          return format_policy.should_use(params.bufname, filetype, "eslint_d")
        end,
      },
      condition = function() return vim.fn.executable "eslint_d" == 1 end,
      factory = helpers.formatter_factory,
    }

    -- Reutiliza a mesma política de raiz dos LSPs: serviço -> workspace -> git -> pasta do arquivo.
    opts.root_dir = project_root.make_rooter(none_ls_markers)

    -- Apenas adiciona novas fontes, sem substituir as já existentes.
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      eslint_d_format,
      null_ls.builtins.formatting.prettierd.with {
        condition = function() return vim.fn.executable "prettierd" == 1 end,
        runtime_condition = function(params)
          local filetype = vim.bo[params.bufnr].filetype
          return format_policy.should_use(params.bufname, filetype, "prettierd")
        end,
        filetypes = prettier_filetypes,
        extra_args = {
          "--semi",
          "false",
          "--single-quote",
          "true",
          "--tab-width",
          "2",
          "--trailing-comma",
          "es5",
        },
      },
      null_ls.builtins.formatting.prettier.with {
        condition = function() return vim.fn.executable "prettier" == 1 end,
        runtime_condition = function(params)
          local filetype = vim.bo[params.bufnr].filetype
          return format_policy.should_use(params.bufname, filetype, "prettier")
        end,
        filetypes = prettier_filetypes,
        extra_args = {
          "--semi",
          "false",
          "--single-quote",
          "true",
          "--tab-width",
          "2",
          "--trailing-comma",
          "es5",
        },
      },
      null_ls.builtins.formatting.isort.with {
        condition = function() return vim.fn.executable "isort" == 1 end,
      },
      null_ls.builtins.formatting.black.with {
        condition = function() return vim.fn.executable "black" == 1 end,
      },
      null_ls.builtins.diagnostics.mypy.with {
        condition = function() return vim.fn.executable "mypy" == 1 end,
      },
      null_ls.builtins.diagnostics.sqlfluff.with {
        condition = function() return vim.fn.executable "sqlfluff" == 1 end,
      },
      null_ls.builtins.formatting.sqlfluff.with {
        condition = function() return vim.fn.executable "sqlfluff" == 1 end,
      },
      null_ls.builtins.formatting.stylua,
    })
  end,
}

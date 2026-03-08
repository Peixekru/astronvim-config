-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@diagnostic disable: param-type-mismatch, missing-parameter, unused-local
local project_root = require "utils.project_root"

local eslint_markers = {
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
  "package.json",
}

local js_ts_markers = {
  "tsconfig.json",
  "tsconfig.base.json",
  "jsconfig.json",
  "package.json",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
}

local vue_markers = {
  "vue.config.js",
  "nuxt.config.ts",
  "nuxt.config.js",
  "vite.config.ts",
  "vite.config.js",
  "tsconfig.json",
  "package.json",
}

local svelte_markers = {
  "svelte.config.js",
  "svelte.config.ts",
  "vite.config.ts",
  "vite.config.js",
  "tsconfig.json",
  "package.json",
}

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = false, -- disable by default to reduce monorepo overhead
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- Personaliza o comportamento de formatação via LSP.
    formatting = {
      -- Controle da formatação automática no salvamento.
      format_on_save = {
        enabled = true, -- Habilita formatar ao salvar.
      },
      disabled = { -- Desativa formatadores de LSP para centralizar em none-ls (prettierd/prettier).
        "eslint", -- Evita disputa de formatação entre ESLint LSP e Prettier.
        "vtsls", -- Usa prettier/prettierd via none-ls.
        "volar", -- Usa prettier/prettierd via none-ls.
      },
      -- Timeout de rotina: prioriza fluidez durante a codificação.
      timeout_ms = 4000,
    },
    -- Personaliza as configurações dos servidores LSP.
    ---@diagnostic disable: missing-fields
    config = {
      eslint = {
        root_dir = project_root.make_rooter(eslint_markers),
        single_file_support = false,
        settings = {
          experimental = { useFlatConfig = true },
          useFlatConfig = true,
          -- Mantém ESLint no contexto correto de cada serviço em monorepo.
          workingDirectories = { mode = "auto" },
        },
      },
      vtsls = {
        root_dir = project_root.make_rooter(js_ts_markers),
        single_file_support = false,
      },
      volar = {
        root_dir = project_root.make_rooter(vue_markers),
        single_file_support = false,
      },
      svelte = {
        root_dir = project_root.make_rooter(svelte_markers),
        single_file_support = false,
      },
      gopls = {
        root_dir = project_root.make_rooter { "go.work", "go.mod" },
        single_file_support = false,
      },
      pyright = {
        root_dir = project_root.make_rooter { "pyproject.toml", "poetry.lock", "requirements.txt", "setup.py" },
        single_file_support = false,
      },
      sqls = {
        root_dir = project_root.make_rooter { ".sqlfluff", ".sqlfluff.toml", ".sqllsrc.json" },
        single_file_support = false,
      },
    },
    -- Personaliza o processo de attach dos servidores.
    handlers = {
      -- a function without a key is simply the default handler
    },
    -- Mapeamentos aplicados quando um LSP conecta ao buffer.
    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    -- Executa após o on_attach padrão do AstroNvim.
    on_attach = function(_, _)
      -- logic to run when an LSP attaches to a buffer
    end,
  },
}

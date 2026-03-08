-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      run_on_start = false,
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- LSP: Frontend & Node Ecosystem
        "vtsls", -- TypeScript/JS (Better than tsserver)
        "vue-language-server", -- Volar (Vue/Nuxt)
        "svelte-language-server", -- Svelte/SvelteKit
        "tailwindcss-language-server",
        "css-lsp", -- CSS/SCSS
        "eslint-lsp", -- ESLint
        "html-lsp", -- HTML
        "json-lsp", -- JSON
        "yaml-language-server", -- YAML (Docker/Config)
        "graphql-language-service-cli", -- GraphQL

        -- LSP: Backend & Systems
        "dockerfile-language-server",
        "docker-compose-language-service",
        "sqls", -- SQL

        -- Study & Future
        "gopls", -- Go
        "rust-analyzer", -- Rust
        "pyright", -- Python
        "ruff", -- Python lint/format fast toolchain
        "lua-language-server", -- Lua (AstroNvim config)

        -- Tools (Formatters, Linters, Debuggers)
        "prettierd", -- Prettier (fast version)
        "eslint_d", -- ESLint (fast version)
        "black", -- Python formatter
        "isort", -- Python import sorter
        "mypy", -- Python type checker
        "sqlfluff", -- SQL linter/formatter
        "stylua", -- Lua formatter for Neovim config
      },
    },
  },
}

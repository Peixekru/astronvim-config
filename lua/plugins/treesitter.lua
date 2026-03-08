-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "css",
      "dockerfile",
      "graphql",
      "gitignore",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "scss",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "vimdoc",
      "vim",
      "vue",
      "yaml",
    },
  },
}

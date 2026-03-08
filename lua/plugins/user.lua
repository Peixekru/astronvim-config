---@type LazySpec
return {
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    opts = {},
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = "╭──────────────────────────────╯  NEOVIM  ╰──────────────────────────────╮",
        },
      },
    },
  },

  { "max397574/better-escape.nvim", enabled = false },
}

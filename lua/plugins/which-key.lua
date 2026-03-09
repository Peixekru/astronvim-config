-- =============================================================================
-- Which-Key Configuration
-- =============================================================================
-- This file configures the window that appears when you press the LEADER key
-- (usually SPACE). This window shows all available shortcuts in the menu.
-- =============================================================================

return {
  "folke/which-key.nvim",
  opts = {
    win = {
      border = "rounded", -- Rounded borders
      padding = { 2, 2, 2, 2 }, -- Inner padding
      title = " Which-Key ", -- Title at the top of the window (with spaces)
      title_pos = "center", -- Title position: "center", "left", or "right"
    },
  },
}

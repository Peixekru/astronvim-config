return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      -- Visual limpo sem bordas laterais
      border = "none",
      mappings = {
        -- 1. Desativa o comportamento de 'seleção' do Espaço que vem por padrão
        ["<space>"] = "none",

        -- 2. Consistência com o Aerial: Setas para Navegar Pastas
        ["<Right>"] = "open",
        ["<Left>"] = "close_node",

        -- 3. Enter: Comportamento padrão (Abre e foca no editor)
        ["<cr>"] = "open",
      },
    },
    -- Estilo dos marcadores de indentação (guias visuais)
    default_component_configs = {
      indent = {
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
      },
    },
  },
}

return {
  {
    "catppuccin",
    opts = {
      -- Configurações globais de transparência
      transparent_background = true, -- Fundo transparente no editor
      float = {
        transparent = true, -- Janelas flutuantes com fundo transparente
        solid = false, -- Não aplicar cor sólida global
      },

      -- My Configs
      custom_highlights = function(colors)
        return {
          -- 1. Transparência Total do Editor Principal e Árvores
          Normal = { bg = "NONE" }, -- Fundo principal (Transparente)
          NormalNC = { bg = "NONE" }, -- Janelas inativas (Transparente)
          NormalSB = { bg = "NONE" }, -- Sidebars (Transparente)
          SignColumn = { bg = "NONE" }, -- Coluna de ícones de erro/git (Esquerda)
          FoldColumn = { bg = "NONE" }, -- Coluna de recolhimento de código
          StatusLine = { bg = "NONE" }, -- Barra de status (opcional, para máxima transparência)
          -- WinSeparator = { bg = "NONE", fg = colors.surface1 }, -- Linhas divisórias entre janelas

          -- 2. Transparência Específica para Neo-tree (Árvore de Arquivos)
          NeoTreeNormal = { bg = "NONE" },
          NeoTreeNormalNC = { bg = "NONE" },
          NeoTreeTabInactive = { bg = "NONE", fg = "#6A6A6B" },
          NeoTreeTabActive = { bg = "NONE", fg = colors.text, bold = true },
          NeoTreeTabSeparatorInactive = { bg = "NONE", fg = "#6A6A6B" },
          NeoTreeTabSeparatorActive = { bg = "NONE", fg = colors.text },
          -- NeoTreeFloatNormal = { bg = "NONE" }, -- Garante transparência em janelas flutuantes do Neo-tree
          NeoTreeWinSeparator = { bg = "NONE", fg = "NONE" },
          -- NeoTreeIndentMarker = { fg = "#313244" }, -- Cor personalizada para os guias de indentação na árvore

          -- 3. Janelas Flutuantes transparentes (consistente com o editor)
          -- NormalFloat = { bg = "NONE" },  -- Herda transparência global
          -- FloatBorder = { fg = colors.blue },  -- Só cor da borda, sem bg
          -- FloatTitle = { fg = colors.text },   -- Só cor do texto, sem bg

          -- 4. Which-Key Title (itálico)
          WhichKeyTitle = { fg = colors.blue, italic = true },

          -- 5. Comentários (mesma cor dos números de linha - discreto)
          Comment = { fg = "#6A6A6B", italic = true },

          -- 6. Aerial (Árvore de Símbolos)
          -- AerialNormal = { bg = "NONE" },
          -- AerialNormalNC = { bg = "NONE" },
          -- AerialGuide = { fg = "#313244" }, -- Cor personalizada para os guias de indentação no Aerial
        }
      end,

      integrations = {
        sandwich = false,
        noice = true,
        mini = true,
        leap = true,
        markdown = true,
        neotest = true,
        cmp = true,
        overseer = true,
        lsp_trouble = true,
        rainbow_delimiters = true,
      },
    },
  },
}

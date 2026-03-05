return {
  "stevearc/aerial.nvim",
  opts = {
    -- 1. Prioridade absoluta para o LSP no Vue (Garante que o <script setup> apareça)
    backends = {
      vue = { "lsp" },
      ["_"] = { "lsp", "treesitter", "markdown", "man" },
    },

    -- 2. Tipos de símbolos exibidos
    filter_kind = {
      "Class", "Constructor", "Enum", "Function", "Interface", "Module",
      "Method", "Struct", "Variable", "Constant", "Field", "Property",
    },

    -- 3. Atalhos personalizados locais (Isolando o comportamento da árvore)
    keymaps = {
      ["<Left>"] = "actions.tree_close",
      ["<Right>"] = "actions.tree_open",
      -- Mapeamos zR e zM localmente para que eles NÃO afetem o editor de código
      ["zR"] = "actions.tree_open_all",
      ["zM"] = "actions.tree_close_all",
    },

    -- 4. Desativar sincronização de dobras (Evita que a árvore mexa no código do editor)
    manage_folds = false,
    link_folds_to_tree = false,
    link_tree_to_folds = false,

    -- 5. Visual e Sincronização
    show_guides = true,
    post_attach_symbol = true,

    -- 6. Força a carga dos dados assim que você abre o arquivo
    on_attach = function(bufnr)
      require("aerial").sync_load()
    end,
  },
}

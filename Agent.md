# 📋 AstroNvim Configuration - Documentation

**Data da última atualização:** Março 2026  
**Versão do AstroNvim:** 5.x  
**Tema:** Catppuccin Mocha (transparente)

---

## 📁 Estrutura de Pastas

```
~/.config/nvim/
├── init.lua                 # Bootstrap do Lazy.nvim
├── lazy-lock.json           # Lock file dos plugins
├── lua/
│   ├── lazy_setup.lua       # Configuração do Lazy.nvim
│   ├── polish.lua           # Configurações finais (desativado)
│   ├── community.lua        # Configurações da comunidade
│   └── plugins/
│       ├── astrocore.lua    # Configurações centrais (maps, options)
│       ├── astrolsp.lua     # Configurações de LSP (desativado)
│       ├── astroui.lua      # Configurações de UI (tema, ícones)
│       ├── catppuccin.lua   # Configurações do tema Catppuccin
│       ├── which-key.lua    # Configurações do Which-Key
│       ├── user.lua         # Configurações customizadas (dashboard)
│       ├── aerial.lua       # Configurações do Aerial
│       ├── mason.lua        # Configurações do Mason (desativado)
│       ├── neo-tree.lua     # Configurações do Neo-tree
│       ├── none-ls.lua      # Configurações do None-ls (desativado)
│       └── treesitter.lua   # Configurações do Treesitter (desativado)
```

---

## 🎨 Tema e Cores

### **Tema Principal**
- **Plugin:** `catppuccin/nvim`
- **Variante:** `catppuccin-mocha`
- **Estilo:** Transparente (mostra fundo do terminal)

### **Configurações de Transparência**

| Elemento | Configuração | Valor |
|----------|-------------|-------|
| Editor Principal | `Normal` | `bg = "NONE"` |
| Janelas Inativas | `NormalNC` | `bg = "NONE"` |
| Sidebars | `NormalSB` | `bg = "NONE"` |
| Coluna de Signs | `SignColumn` | `bg = "NONE"` |
| Fold Column | `FoldColumn` | `bg = "NONE"` |
| Status Line | `StatusLine` | `bg = "NONE"` |
| Neo-tree | `NeoTreeNormal` | `bg = "NONE"` |
| Janelas Flutuantes | `NormalFloat` | Herda transparência global |

### **Cores Personalizadas**

| Highlight | Cor | Descrição |
|-----------|-----|-----------|
| `LineNr` | `#45475a` | Números de linha (Overlay0) |
| `Comment` | `#45475a` + itálico | Comentários (mesma cor dos números) |
| `WhichKeyTitle` | `colors.blue` + itálico | Título do Which-Key |

### **Configurações Globais do Catppuccin**

```lua
transparent_background = true   -- Fundo transparente
float = {
  transparent = true,           -- Janelas flutuantes transparentes
  solid = false,                -- Sem cor sólida global
}
```

---

## ⌨️ Atalhos de Teclado

### **Leader Key**
- **Tecla:** `espaço`
- **Local Leader:** `,`

### **Atalhos Personalizados**

| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<Leader>L` | `:Lazy` | Abre o gerenciador de plugins Lazy |
| `<Leader>bd` | Buffer Picker | Fecha buffer da tabline |
| `]b` | Next Buffer | Navega para próximo buffer |
| `[b` | Previous Buffer | Navega para buffer anterior |

### **Neo-tree (Árvore de Arquivos)**

| Tecla | Ação |
|-------|------|
| `<Right>` | Abrir pasta |
| `<Left>` | Fechar pasta |
| `<Enter>` | Abrir arquivo e focar no editor |
| `<Space>` | Desativado (era seleção) |

---

## 🖼️ UI e Aparência

### **Bordas**
- **Lazy.nvim:** `border = "rounded"` (arredondadas)
- **Which-Key:** `border = "rounded"` (arredondadas)
- **Neo-tree:** `border = "none"` (sem bordas)

### **Which-Key**
- **Título:** `" Start "` (com espaços)
- **Estilo:** Itálico azul
- **Posição do título:** Centralizado

### **Dashboard (Snacks.nvim)**
- **Header:** `"╭──────────────────────────────╯  Neovim  ╰──────────────────────────────╮"`
- **Estilo:** Linha única estilizada simétrica

### **Opções de Blend**
```lua
winblend = 0    -- Janelas flutuantes: 0% blend (opacas)
pumblend = 0    -- Menu popup: 0% blend (opacos)
```

### **Fill Characters**
```lua
fillchars = "vert: ,eob: "  -- Remove linha vertical e ~ após o buffer
```

---

## 📦 Plugins Ativos

### **Core**
- `lazy.nvim` - Gerenciador de plugins
- `astrocore` - Configurações centrais
- `astrolsp` - LSP (desativado no config)
- `astroui` - Interface e tema

### **Tema**
- `catppuccin/nvim` - Tema de cores

### **UI/UX**
- `snacks.nvim` - Dashboard e notificações
- `which-key.nvim` - Menu de atalhos
- `neo-tree.nvim` - Árvore de arquivos
- `aerial.nvim` - Navegador de símbolos
- `heirline` - Status line e tabline

### **LSP & Completion**
- `nvim-lspconfig` - Configuração de LSP
- `mason.nvim` - Gerenciador de servidores LSP
- `mason-lspconfig.nvim` - Integração Mason + LSP
- `none-ls.nvim` - Linters e formatters (desativado)
- `cmp` - Autocompletion

### **Outros**
- `treesitter` - Syntax highlighting
- `gitsigns.nvim` - Git signs
- `telescope.nvim` - Fuzzy finder
- `toggleterm.nvim` - Terminal integrado
- `rainbow-delimiters` - Delimitadores coloridos

---

## 🔧 Configurações por Arquivo

### **`lua/plugins/catppuccin.lua`**
```lua
-- Configurações principais:
transparent_background = true
float = { transparent = true, solid = false }

-- Highlights customizados:
Normal = { bg = "NONE" }
NormalNC = { bg = "NONE" }
NormalSB = { bg = "NONE" }
Comment = { fg = "#45475a", italic = true }
WhichKeyTitle = { fg = colors.blue, italic = true }
```

### **`lua/lazy_setup.lua`**
```lua
ui = {
  border = "rounded",  -- Bordas arredondadas no Lazy
}
```

### **`lua/plugins/astrocore.lua`**
```lua
options = {
  opt = {
    fillchars = "vert: ,eob: ",
    winblend = 0,
    pumblend = 0,
  }
}

mappings = {
  n = {
    ["<Leader>L"] = { function() require("lazy").home() end, desc = "Lazy (Plugins)" },
  }
}
```

### **`lua/plugins/which-key.lua`**
```lua
win = {
  border = "rounded",
  padding = { 2, 2, 2, 2 },
  title = " Start ",
  title_pos = "center",
}
```

### **`lua/plugins/user.lua`**
```lua
-- Dashboard header:
header = "╭──────────────────────────────╯  Neovim  ╰──────────────────────────────╮"
```

### **`lua/plugins/neo-tree.lua`**
```lua
window = {
  border = "none",
  mappings = {
    ["<Right>"] = "open",
    ["<Left>"] = "close_node",
    ["<cr>"] = "open",
  }
}
```

---

## 🎯 Comandos Úteis

### **Gerenciamento de Plugins**
```vim
:Lazy              " Abre o gerenciador de plugins
:Lazy update       " Atualiza todos os plugins
:Lazy sync         " Atualiza e sincroniza plugins
:Lazy clean        " Remove plugins não utilizados
```

### **Tema e Cores**
```vim
:hi Normal         " Ver highlight do Normal
:hi LineNr         " Ver highlight dos números de linha
:hi Comment        " Ver highlight de comentários
:hi DiagnosticError " Ver highlight de erro
```

### **Buffer e Janelas**
```vim
:bd                " Fecha buffer atual
:bn                " Próximo buffer
:bp                " Buffer anterior
```

---

## 🐛 Problemas Comuns e Soluções

### **Janelas flutuantes com vazamento de cor**
**Solução:** Configurar `transparent_background = true` e `float.transparent = true` no catppuccin.

### **Which-Key sem bordas**
**Solução:** Adicionar `border = "rounded"` nas opções `win` do which-key.

### **Dashboard não carrega**
**Solução:** Remover ou comentar `if true then return {} end` no arquivo `user.lua`.

### **Erro no catppuccin após adicionar highlight**
**Solução:** Usar `italic = true` em vez de `style = "italic"`.

---

## 📚 Recursos e Links

### **Documentação Oficial**
- [AstroNvim Docs](https://astronvim.com/)
- [Catppuccin Nvim](https://github.com/catppuccin/nvim)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Which-Key](https://github.com/folke/which-key.nvim)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)

### **Comunidade**
- [AstroNvim Discord](https://discord.gg/astronvim)
- [Catppuccin Discord](https://discord.gg/catppuccin)

---

## 🔄 Histórico de Mudanças

### **Março 2026**
- ✅ Tema catppuccin-mocha com transparência total
- ✅ Bordas arredondadas no Lazy e Which-Key
- ✅ Which-Key com título "Start" em itálico azul
- ✅ Dashboard com header minimalista
- ✅ Atalho `<Leader>L` para Lazy
- ✅ Comentários na mesma cor dos números de linha (#45475a)
- ✅ Neo-tree sem bordas e transparente
- ✅ winblend e pumblend configurados para 0

---

## 💡 Dicas de Personalização

### **Mudar cor dos comentários**
Edite em `catppuccin.lua`:
```lua
Comment = { fg = "#SUA_COR", italic = true }
```

### **Mudar título do Which-Key**
Edite em `which-key.lua`:
```lua
title = " Seu Título ",
```

### **Mudar estilo da borda**
Opções: `"single"`, `"double"`, `"rounded"`, `"solid"`, `"shadow"`, `"none"`

### **Ativar/desativar plugins**
Em qualquer arquivo de plugin:
```lua
if true then return {} end  -- Desativa o arquivo
-- if true then return {} end  -- Ativa o arquivo
```

---

## 🎨 Paleta Catppuccin Mocha

| Cor | Hex | Nome |
|-----|-----|------|
| Base | `#1e1e2e` | Fundo principal |
| Surface0 | `#313244` | Superfície clara |
| Surface1 | `#45475a` | Superfície média |
| Overlay0 | `#6c7086` | Overlay claro |
| Overlay1 | `#7f849c` | Overlay médio |
| Overlay2 | `#9399b2` | Overlay forte |
| Blue | `#89b4fa` | Azul |
| Red | `#f38ba8` | Vermelho |
| Green | `#a6e3a1` | Verde |
| Yellow | `#f9e2af` | Amarelo |
| Pink | `#f5c2e7` | Rosa |
| Mauve | `#cba6f7` | Roxo |
| Teal | `#94e2d5` | Turquesa |

---

**Fim da documentação.** 🚀

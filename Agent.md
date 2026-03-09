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
│   ├── polish.lua           # Comandos utilitários (FormatForce, Swap*, RootInfo)
│   ├── community.lua        # Configurações da comunidade
│   ├── utils/
│   │   └── project_root.lua # Regra central de detecção de raiz (serviço/workspace/git)
│   └── plugins/
│       ├── astrocore.lua    # Configurações centrais (maps, options)
│       ├── astrolsp.lua     # Configurações de LSP
│       ├── astroui.lua      # Configurações de UI (tema, ícones)
│       ├── catppuccin.lua   # Configurações do tema Catppuccin
│       ├── which-key.lua    # Configurações do Which-Key
│       ├── user.lua         # Configurações customizadas (dashboard)
│       ├── aerial.lua       # Configurações do Aerial
│       ├── mason.lua        # Configurações do Mason
│       ├── neo-tree.lua     # Configurações do Neo-tree
│       ├── none-ls.lua      # Configurações do None-ls
│       └── treesitter.lua   # Configurações do Treesitter
```

---

## 🗂️ Organização Estendida (Plugins e Configurações)

### **Ordem de carregamento (fonte da verdade)**
1. `init.lua` -> bootstrap do Lazy.
2. `lua/lazy_setup.lua` -> registra imports base.
3. `lua/community.lua` -> packs do AstroCommunity.
4. `lua/plugins/*.lua` -> overrides e plugins custom por domínio.
5. `lua/polish.lua` -> comandos e ajustes finais pós-inicialização.

### **Organização por domínio funcional**

| Domínio | Arquivos | Objetivo |
|---------|----------|----------|
| Bootstrap | `init.lua`, `lua/lazy_setup.lua` | Subir Lazy + AstroNvim com opções globais |
| Packs Community | `lua/community.lua` | Habilitar stacks prontas (Vue, Svelte, TS, Copilot, Flash) |
| Core Editor | `lua/plugins/astrocore.lua`, `lua/plugins/astroui.lua` | Maps, options, tema ativo, ícones |
| Tema e Highlights | `lua/plugins/catppuccin.lua`, `lua/plugins/which-key.lua` | Aparência, transparência e componentes visuais |
| Navegação UI | `lua/plugins/neo-tree.lua`, `lua/plugins/aerial.lua`, `lua/plugins/user.lua` | Árvore de arquivos, símbolos e dashboard |
| Linguagens e LSP | `lua/plugins/astrolsp.lua`, `lua/plugins/mason.lua`, `lua/plugins/none-ls.lua`, `lua/plugins/treesitter.lua` | LSP, ferramentas externas, formatação/lint e parsing |
| Infra de Root | `lua/utils/project_root.lua` | Política única de detecção de raiz |
| Operação diária | `lua/polish.lua` | Comandos de diagnóstico, formatação e manutenção |

### **Matriz plugin -> arquivo -> responsabilidade**

| Plugin | Arquivo | Responsabilidade |
|--------|---------|------------------|
| `AstroNvim/astrocore` | `lua/plugins/astrocore.lua` | Opções globais e keymaps base |
| `AstroNvim/astrolsp` | `lua/plugins/astrolsp.lua` | Config LSP por linguagem + política de format_on_save |
| `AstroNvim/astroui` | `lua/plugins/astroui.lua` | Corescheme ativo e ícones da interface |
| `catppuccin/nvim` | `lua/plugins/catppuccin.lua` | Transparência e highlights customizados |
| `folke/which-key.nvim` | `lua/plugins/which-key.lua` | Janela e estilo do menu de atalhos |
| `nvim-neo-tree/neo-tree.nvim` | `lua/plugins/neo-tree.lua` | Árvore de arquivos e keymaps de navegação |
| `stevearc/aerial.nvim` | `lua/plugins/aerial.lua` | Símbolos por buffer, sem interferir em folds do editor |
| `nvimtools/none-ls.nvim` | `lua/plugins/none-ls.lua` | Formatadores e diagnósticos externos (Prettier, Python, SQL, Lua) |
| `WhoIsSethDaniel/mason-tool-installer.nvim` | `lua/plugins/mason.lua` | Garantir instalação de LSPs e ferramentas |
| `nvim-treesitter/nvim-treesitter` | `lua/plugins/treesitter.lua` | Parsers para destaque e estrutura sintática |
| `folke/snacks.nvim` | `lua/plugins/user.lua` | Header do dashboard |
| `ray-x/lsp_signature.nvim` | `lua/plugins/user.lua` | Assinatura inline de funções no modo insert |

### **Convenções de manutenção**
- Cada arquivo em `lua/plugins/` deve ter um único objetivo funcional.
- Regras de root devem ficar centralizadas apenas em `lua/utils/project_root.lua`.
- Qualquer plugin novo deve ser documentado nesta matriz com: plugin, arquivo e responsabilidade.
- Ajustes operacionais (comandos `:...`) devem entrar em `lua/polish.lua`, não em arquivos de plugin.

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
| `Comment` | `#6A6A6B` + itálico | Comentários discretos |
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
- **Header:** `"╭──────────────────────────────╯  NEOVIM  ╰──────────────────────────────╮"`
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
- `astrolsp` - LSP
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
- `none-ls.nvim` - Linters e formatters
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
Comment = { fg = "#6A6A6B", italic = true }
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
header = "╭──────────────────────────────╯  NEOVIM  ╰──────────────────────────────╮"
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

## 🧭 Política de Contexto de Projeto (Mono e Não-Mono)

### **Ordem oficial de detecção de raiz**
1. Marcadores técnicos do serviço (mais próximos do arquivo)
2. Marcadores de workspace/monorepo
3. Raiz git (`.git`)
4. Diretório do arquivo (fallback final)

### **Marcadores de workspace/monorepo**
- `package.json` com `workspaces`
- `pnpm-workspace.yaml`
- `turbo.json`
- `nx.json`
- `lerna.json`
- `rush.json`

### **Diagnóstico rápido**
```vim
:RootInfo          " Mostra root detectada, motivo, LSPs ativos e formatters
```

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

### **Março 2026 — Registro Técnico Detalhado**

#### **1) Ajustes de stack frontend e ecossistema**
- ✅ `community.lua`:
  - mantido `pack.vue`
  - adicionado `pack.svelte`
  - mantido `pack.typescript` (React via TS/TSX)
  - removido `pack.react` (módulo inexistente no astrocommunity instalado)
- ✅ Resultado:
  - cobertura prática para Vue + Svelte + React (via TS/TSX)
  - sem erro de inicialização por import inválido

#### **2) Estratégia de formatação (dois cenários)**
- ✅ `astrolsp.lua`:
  - `format_on_save.enabled = true`
  - `formatting.timeout_ms = 4000` (fluxo rápido no salvar)
  - desativado formatador de `eslint`, `vtsls` e `volar` para evitar disputa com `none-ls`
- ✅ `polish.lua`:
  - comando `:FormatForce` (padrão 20000ms, aceita argumento, ex.: `:FormatForce 60000`)
  - comando `:FormatForceMax` (60000ms fixo)
  - comando `:FormatInfo` (mostra qual formatador foi priorizado e por quê)
- ✅ Política atual:
  - o projeto é a fonte da verdade para lint/format
  - em projetos web com evidência explícita de Prettier (`.prettierrc`, `prettier.config.*`, `package.json#prettier` ou dependências relacionadas), `prettier/prettierd` é priorizado
  - em projetos web com ESLint e sem evidência de Prettier, `eslint_d --fix-to-stdout` é priorizado via `none-ls`
  - LSPs (`eslint`, `vtsls`, `volar`) permanecem sem formatação para evitar disputa
- ✅ Resultado:
  - salvar continua fluido no dia a dia
  - existe caminho explícito para arquivo grande/legado
  - a decisão de formatador fica previsível e auditável por buffer

#### **3) none-ls e estabilidade de lint/format**
- ✅ `none-ls.lua`:
  - política de format definida por projeto: `eslint_d` ou `prettierd` -> fallback `prettier`
  - `prettierd/prettier` limitados a filetypes web (`js/ts/tsx/vue/svelte/json/yaml/css/scss/html/markdown`)
  - `eslint_d` de formatting implementado como source custom (`--fix-to-stdout`) porque o builtin não existe nessa versão instalada do none-ls
  - removido `eslint_d` de diagnostics/code_actions (builtin ausente na versão instalada do none-ls)
- ✅ Resultado:
  - eliminado erro de load: `attempt to index field 'eslint_d' (a nil value)`
  - comportamento mais previsível entre projetos
  - o editor para de impor `prettier` em todo caso web e passa a respeitar o contrato do repositório

#### **3.1) Conflito Prettier x ESLint em projeto Vue real**
- ✅ Caso observado:
  - arquivo `frontend/src/components/Logout.vue` em `Documents/dev/pertencer-lideres/...`
  - warning do ESLint: `vue/singleline-html-element-content-newline`
  - `prettier` reformatava o arquivo para um estilo rejeitado por essa regra
- ✅ Diagnóstico:
  - o problema não era o Neovim
  - havia conflito de política dentro do projeto: Prettier formatando e ESLint cobrando estilo incompatível
- ✅ Decisão adotada:
  - seguir a prática atual do ecossistema Vue: Prettier manda na formatação; ESLint fica com qualidade/lint
  - aplicar `eslint-config-prettier` no `eslint.config.js` do projeto
- ✅ Resultado:
  - o warning desapareceu
  - salvar com Prettier deixou de reintroduzir formato rejeitado pelo ESLint
  - lição operacional: quando houver impasse Prettier x ESLint, corrigir a configuração do projeto antes de mexer na configuração global do editor

#### **4) Gestão de swap e erro E325**
- ✅ `polish.lua`:
  - comando `:SwapList` (listar swaps órfãos)
  - comando `:SwapClean` e `:SwapClean!` (limpeza segura com confirmação)
- ✅ Resultado:
  - processo padronizado para resolver `E325: ATTENTION`
  - redução de bloqueios ao abrir arquivos pelo Neo-tree

#### **5) Política de contexto de projeto (mono e não-mono)**
- ✅ Novo arquivo: `lua/utils/project_root.lua`
  - regra oficial de root:
    1. marcadores técnicos do serviço
    2. marcadores de workspace/monorepo
    3. `.git`
    4. diretório do arquivo (fallback final)
  - marcadores de workspace:
    - `package.json` com `workspaces`
    - `pnpm-workspace.yaml`
    - `turbo.json`
    - `nx.json`
    - `lerna.json`
    - `rush.json`
- ✅ `astrolsp.lua` e `none-ls.lua` migrados para usar a mesma política central
- ✅ `polish.lua`:
  - comando `:RootInfo` para exibir:
    - arquivo atual
    - filetype
    - root detectada
    - motivo da root (`servico`, `workspace`, `git`, `diretorio_do_arquivo`)
    - clientes LSP ativos
    - formatadores detectados
- ✅ Resultado:
  - detecção consistente entre LSP e none-ls
  - diagnóstico operacional rápido quando algo não anexa

#### **6) Testes de smoke executados**
- ✅ React (`Desktop/nvim-lsp-tests/react-smoke`):
  - LSPs ativos observados: `eslint`, `vtsls`, `null-ls`
  - lint proposital validado (`no-unused-vars`)
  - `:FormatForce` e `:FormatForceMax` validados
- ✅ Svelte (`Desktop/nvim-lsp-tests/svelte-smoke`):
  - LSP `svelte` instalado e ativo
  - diagnóstico de tipo em `App.svelte` validado manualmente
- ✅ Resultado:
  - fluxo principal de frontend validado manualmente pelo usuário

#### **7) Copilot inline (modo padrão)**
- ✅ `community.lua`:
  - adicionado `astrocommunity.completion.copilot-lua`
- ✅ Plugin instalado via `:Lazy sync`:
  - `zbirenbaum/copilot.lua`
- ✅ Estado padrão atual:
  - `suggestion.auto_trigger = true`
  - `debounce = 150` (config do pack community)
- ✅ Atalho padrão de aceitar sugestão:
  - `<M-l>` (Alt + l)
- ✅ Autenticação:
  - `:Copilot auth` (ou `:Copilot setup`)
  - credenciais em `~/.config/github-copilot/apps.json`

#### **8) Padrões de trabalho definidos**
- ✅ Não implementar mudanças sem explicar antes:
  - o que
  - onde
  - por que
  - como
- ✅ Comentários novos em código: pt-BR
- ✅ Evolução incremental e validada por etapa pequena

#### **9) Arquivos impactados no ciclo**
- `lua/community.lua`
- `lua/plugins/astrolsp.lua`
- `lua/plugins/none-ls.lua`
- `lua/plugins/mason.lua`
- `lua/plugins/treesitter.lua`
- `lua/polish.lua`
- `lua/utils/project_root.lua` (novo)
- `lazy-lock.json`
- `Agent.md`

#### **10) Comandos operacionais ativos**
- `:FormatForce [timeout_ms]`
- `:FormatForceMax`
- `:FormatInfo`
- `:SwapList`
- `:SwapClean` / `:SwapClean!`
- `:RootInfo`
- `:Copilot auth`
- ✅ Comentários em tom discreto com itálico (`#6A6A6B`)
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

---

## 🧪 Sugestões de Revisão e Melhorias (Perfil Tiago)

### **Contexto do perfil considerado**
- Foco principal: frontend no ecossistema JavaScript/TypeScript
- Stack atual: Vue (principal), React e Svelte (prontas para uso)
- Preferência de uso: assistências visuais discretas, estabilidade e previsibilidade
- Fluxo de trabalho: evolução incremental, sem mudanças bruscas
- Hardware: ambiente mais antigo, priorizando fluidez no dia a dia

### **Revisão semanal recomendada (15-20 min)**
1. Verificar status dos plugins:
   - `:Lazy`
2. Diagnósticos mais visíveis:
   - adicionar nota futura: resolver o "erro só aparece no fim" com UX de diagnostics (Trouble/tiny-inline) para apontar a linha de abertura nos casos sintáticos
   - `:Lazy check`
2. Verificar contexto e anexos de LSP em projeto ativo:
   - `:RootInfo`
   - `:LspInfo`
3. Verificar se o autosave-format está equilibrado:
   - salvar arquivo comum com `leader + w`
   - usar `:FormatForce` em arquivo grande
4. Limpar swaps órfãos quando necessário:
   - `:SwapList`
   - `:SwapClean!`

### **Melhorias priorizadas (curto prazo)**
1. Ajustar keymap de aceitar Copilot para terminal atual (se `<M-l>` não for estável).
2. Criar variação de perfil visual por camadas (suave/equilibrado/intenso), mantendo tema atual.
3. Padronizar checklist de validação rápida ao iniciar projeto novo:
   - abrir arquivo da stack
   - `:LspInfo`
   - `:RootInfo`
   - salvar e validar formatação

### **Melhorias de médio prazo (quando fizer sentido)**
1. Avaliar `blink-copilot` para integrar sugestões IA no menu de completion (sem substituir inline).
2. Criar comando de auditoria leve para exibir resumo de saúde do ambiente:
   - LSPs instalados
   - formatadores disponíveis
   - comandos custom ativos
3. Refinar regras por linguagem para reduzir ainda mais ruído de diagnóstico em projetos híbridos.

### **Critérios de sucesso para futuras melhorias**
1. Não quebrar fluxo de codificação durante `:w`.
2. Não introduzir dependência de nomes de pastas para detectar contexto.
3. Toda melhoria nova deve ser:
   - explicada antes (o que/onde/por que/como)
   - validada com teste simples
   - documentada neste arquivo

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

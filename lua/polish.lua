-- Executa no final da inicialização do AstroNvim.
-- Mantenha aqui ajustes finais e agnósticos de projeto.

-- Formatação manual com timeout maior para arquivos grandes.
-- Uso:
--   :FormatForce         -> timeout padrão de 20000ms
--   :FormatForce 60000   -> timeout customizado (ex.: 1 minuto)
vim.api.nvim_create_user_command("FormatForce", function(opts)
  local timeout_ms = 20000

  if opts.args ~= "" then
    local parsed = tonumber(opts.args)
    if parsed and parsed > 0 then timeout_ms = parsed end
  end

  vim.lsp.buf.format {
    bufnr = 0,
    async = false,
    timeout_ms = timeout_ms,
  }
end, {
  nargs = "?",
  desc = "Forca formatacao do buffer atual com timeout customizavel",
})

-- Atalho explícito para cenário extremo: arquivo muito grande.
vim.api.nvim_create_user_command("FormatForceMax", function()
  vim.lsp.buf.format {
    bufnr = 0,
    async = false,
    timeout_ms = 60000,
  }
end, {
  nargs = 0,
  desc = "Forca formatacao com timeout de 60000ms",
})

-- Diretório padrão de swap do Neovim nesta configuração.
local swap_dir = vim.fn.stdpath "state" .. "/swap"

-- Retorna a lista de arquivos de swap válidos no diretório padrão.
local function get_swap_files()
  local files = vim.fn.globpath(swap_dir, "*", false, true)
  local swaps = {}

  for _, file in ipairs(files) do
    if file:match("%.swp$") or file:match("%.swo$") or file:match("%.swn$") then
      table.insert(swaps, file)
    end
  end

  table.sort(swaps)
  return swaps
end

-- Lista swaps existentes para diagnóstico rápido.
vim.api.nvim_create_user_command("SwapList", function()
  local swaps = get_swap_files()
  if #swaps == 0 then
    vim.notify("Nenhum arquivo de swap encontrado em " .. swap_dir, vim.log.levels.INFO)
    return
  end

  vim.notify("Swaps encontrados: " .. #swaps, vim.log.levels.WARN)
  for _, file in ipairs(swaps) do
    vim.notify(file, vim.log.levels.INFO)
  end
end, {
  nargs = 0,
  desc = "Lista arquivos de swap do Neovim",
})

-- Remove swaps órfãos do diretório padrão (somente com confirmação via !).
vim.api.nvim_create_user_command("SwapClean", function(opts)
  local swaps = get_swap_files()
  if #swaps == 0 then
    vim.notify("Nenhum swap para remover em " .. swap_dir, vim.log.levels.INFO)
    return
  end

  if not opts.bang then
    vim.notify("Use :SwapClean! para confirmar a remoção de " .. #swaps .. " swap(s).", vim.log.levels.WARN)
    return
  end

  local removed = 0
  for _, file in ipairs(swaps) do
    local ok = os.remove(file)
    if ok then removed = removed + 1 end
  end

  vim.notify("SwapClean concluído: " .. removed .. "/" .. #swaps .. " removido(s).", vim.log.levels.INFO)
end, {
  bang = true,
  nargs = 0,
  desc = "Remove arquivos de swap do Neovim (use ! para confirmar)",
})

-- Mostra um diagnóstico rápido de contexto do buffer atual.
vim.api.nvim_create_user_command("RootInfo", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local filetype = vim.bo[bufnr].filetype
  local project_root = require "utils.project_root"

  local markers_by_filetype = {
    javascript = { "tsconfig.json", "jsconfig.json", "package.json", "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts" },
    javascriptreact = { "tsconfig.json", "jsconfig.json", "package.json", "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts" },
    typescript = { "tsconfig.json", "tsconfig.base.json", "package.json", "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts" },
    typescriptreact = { "tsconfig.json", "tsconfig.base.json", "package.json", "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts" },
    vue = { "vue.config.js", "nuxt.config.ts", "nuxt.config.js", "vite.config.ts", "vite.config.js", "tsconfig.json", "package.json" },
    svelte = { "svelte.config.js", "svelte.config.ts", "vite.config.ts", "vite.config.js", "tsconfig.json", "package.json" },
    python = { "pyproject.toml", "poetry.lock", "requirements.txt", "setup.py" },
    go = { "go.work", "go.mod" },
    sql = { ".sqlfluff", ".sqlfluff.toml", ".sqllsrc.json" },
  }

  local markers = markers_by_filetype[filetype] or { "package.json" }
  local root, reason = project_root.detect(file_path, markers)

  local clients = vim.lsp.get_clients { bufnr = bufnr }
  local client_lines = {}
  for _, client in ipairs(clients) do
    local client_root = client.config and client.config.root_dir or "sem_root_dir"
    table.insert(client_lines, string.format("- %s | root: %s", client.name, client_root))
  end
  if #client_lines == 0 then table.insert(client_lines, "- nenhum cliente LSP ativo") end

  local formatter_names = {}
  local ok_sources, sources = pcall(require, "null-ls.sources")
  local ok_methods, methods = pcall(require, "null-ls.methods")
  if ok_sources and ok_methods then
    local available = sources.get_available(filetype, methods.internal.FORMATTING)
    local unique = {}
    for _, source in ipairs(available) do unique[source.name] = true end
    for name, _ in pairs(unique) do
      table.insert(formatter_names, name)
    end
    table.sort(formatter_names)
  end
  if #formatter_names == 0 then table.insert(formatter_names, "nenhum formatter detectado") end

  local message = table.concat({
    "RootInfo",
    "arquivo: " .. (file_path ~= "" and file_path or "[sem caminho]"),
    "filetype: " .. (filetype ~= "" and filetype or "[sem filetype]"),
    "root detectada: " .. root,
    "motivo da root: " .. reason,
    "LSPs ativos:",
    table.concat(client_lines, "\n"),
    "formatters:",
    "- " .. table.concat(formatter_names, ", "),
  }, "\n")

  vim.notify(message, vim.log.levels.INFO)
end, {
  nargs = 0,
  desc = "Mostra raiz detectada, LSPs ativos e formatadores do buffer",
})

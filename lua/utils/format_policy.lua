-- Politica de selecao de formatador por projeto.
-- Objetivo: o editor deve obedecer ao contrato do repositorio.

local M = {}

local uv = vim.uv or vim.loop
local project_root = require "utils.project_root"

local eslint_markers = {
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
}

local prettier_markers = {
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.js",
  ".prettierrc.cjs",
  ".prettierrc.mjs",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  "prettier.config.js",
  "prettier.config.cjs",
  "prettier.config.mjs",
}

local web_markers = {
  "tsconfig.json",
  "tsconfig.base.json",
  "jsconfig.json",
  "package.json",
  "vite.config.ts",
  "vite.config.js",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
}

local web_filetypes = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  vue = true,
  svelte = true,
  json = true,
  jsonc = true,
  yaml = true,
  markdown = true,
  ["markdown.mdx"] = true,
  css = true,
  scss = true,
  html = true,
}

local function file_exists(path) return uv.fs_stat(path) ~= nil end

local function read_json_file(path)
  if not file_exists(path) then return nil end
  local ok_read, lines = pcall(vim.fn.readfile, path)
  if not ok_read or not lines then return nil end

  local ok_json, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
  if not ok_json or type(decoded) ~= "table" then return nil end
  return decoded
end

local function root_for(bufname)
  local root, _ = project_root.detect(bufname, web_markers)
  return root
end

local function has_any_marker(root, markers)
  for _, marker in ipairs(markers) do
    if file_exists(root .. "/" .. marker) then return true, marker end
  end
  return false, nil
end

local function package_json_info(root)
  local package_json = read_json_file(root .. "/package.json")
  if not package_json then
    return {
      has_prettier_field = false,
      has_prettier_dep = false,
      has_eslint_dep = false,
    }
  end

  local function has_dep(name)
    local groups = {
      package_json.dependencies,
      package_json.devDependencies,
      package_json.peerDependencies,
      package_json.optionalDependencies,
    }

    for _, deps in ipairs(groups) do
      if type(deps) == "table" and deps[name] ~= nil then return true end
    end

    return false
  end

  return {
    has_prettier_field = package_json.prettier ~= nil,
    has_prettier_dep = has_dep "prettier" or has_dep "prettierd" or has_dep "eslint-plugin-prettier" or has_dep "eslint-config-prettier",
    has_eslint_dep = has_dep "eslint" or has_dep "eslint_d" or has_dep "eslint-plugin-vue" or has_dep "@typescript-eslint/eslint-plugin",
  }
end

function M.is_web_filetype(filetype) return web_filetypes[filetype] == true end

function M.get_decision(bufname, filetype)
  if not M.is_web_filetype(filetype) then
    return nil
  end

  local root = root_for(bufname)
  local has_eslint, eslint_marker = has_any_marker(root, eslint_markers)
  local has_prettier_config, prettier_marker = has_any_marker(root, prettier_markers)
  local package_info = package_json_info(root)
  local has_prettier = has_prettier_config or package_info.has_prettier_field or package_info.has_prettier_dep

  if has_eslint and not has_prettier then
    return {
      root = root,
      formatter = "eslint_d",
      reason = "projeto com ESLint e sem evidencia de Prettier",
      details = eslint_marker or "eslint.config",
    }
  end

  if has_prettier then
    local executable = vim.fn.executable "prettierd" == 1 and "prettierd" or "prettier"
    return {
      root = root,
      formatter = executable,
      reason = "projeto com Prettier explicito ou dependencias relacionadas",
      details = prettier_marker or (package_info.has_prettier_field and "package.json#prettier" or "dependencias do package.json"),
    }
  end

  if has_eslint then
    return {
      root = root,
      formatter = "eslint_d",
      reason = "fallback para ESLint porque nao ha config dedicada de Prettier",
      details = eslint_marker or "eslint.config",
    }
  end

  local executable = vim.fn.executable "prettierd" == 1 and "prettierd" or "prettier"
  return {
    root = root,
    formatter = executable,
    reason = "fallback para Prettier em projeto web sem regra explicita",
    details = "sem config dedicada encontrada",
  }
end

function M.should_use(bufname, filetype, formatter_name)
  local decision = M.get_decision(bufname, filetype)
  return decision ~= nil and decision.formatter == formatter_name
end

return M

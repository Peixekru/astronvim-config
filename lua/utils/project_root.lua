-- Regras centrais de detecção de raiz de projeto.
-- Objetivo: manter comportamento previsível em mono e não-monorepo.

local M = {}

local uv = vim.uv or vim.loop

local workspace_markers = {
  "pnpm-workspace.yaml",
  "turbo.json",
  "nx.json",
  "lerna.json",
  "rush.json",
}

local function file_exists(path) return uv.fs_stat(path) ~= nil end

local function dirname(path)
  if path == "" then return vim.loop.cwd() end
  return vim.fs.dirname(path) or path
end

local function normalize_start_path(path)
  if path == "" then return vim.loop.cwd() end
  local stat = uv.fs_stat(path)
  if stat and stat.type == "file" then return dirname(path) end
  return path
end

local function parent_dir(path)
  local parent = dirname(path)
  if parent == path then return nil end
  return parent
end

local function find_up(start_dir, predicate)
  local current = start_dir
  while current do
    if predicate(current) then return current end
    current = parent_dir(current)
  end
  return nil
end

local function has_any_marker(dir, markers)
  for _, marker in ipairs(markers) do
    if file_exists(dir .. "/" .. marker) then return true, marker end
  end
  return false, nil
end

local function package_json_has_workspaces(dir)
  local path = dir .. "/package.json"
  if not file_exists(path) then return false end

  local ok_read, lines = pcall(vim.fn.readfile, path)
  if not ok_read or not lines then return false end

  local ok_json, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
  if not ok_json or type(decoded) ~= "table" then return false end

  return decoded.workspaces ~= nil
end

function M.detect(path, service_markers)
  local start_dir = normalize_start_path(path)
  service_markers = service_markers or {}

  -- 1) Prioriza a raiz local do serviço (marcadores técnicos próximos do arquivo).
  local service_root = find_up(start_dir, function(dir)
    local has, _ = has_any_marker(dir, service_markers)
    return has
  end)
  if service_root then return service_root, "servico" end

  -- 2) Depois tenta a raiz de workspace/monorepo por marcadores dedicados.
  local workspace_root = find_up(start_dir, function(dir)
    local has_workspace_marker, _ = has_any_marker(dir, workspace_markers)
    if has_workspace_marker then return true end
    return package_json_has_workspaces(dir)
  end)
  if workspace_root then return workspace_root, "workspace" end

  -- 3) Fallback clássico: raiz git.
  local git_root = find_up(start_dir, function(dir) return file_exists(dir .. "/.git") end)
  if git_root then return git_root, "git" end

  -- 4) Último fallback: diretório do próprio arquivo.
  return start_dir, "diretorio_do_arquivo"
end

function M.make_rooter(service_markers)
  return function(fname)
    local root, _ = M.detect(fname, service_markers)
    return root
  end
end

return M

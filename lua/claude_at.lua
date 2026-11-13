-- ~/.config/nvim/lua/claude_at.lua
-- Data sources for the Claude Code @-picker script.
-- In init.lua:  require("claude_at").setup()

local M = {}

local function rel(path, root)
  if root and path:sub(1, #root + 1) == root .. "/" then
    return path:sub(#root + 2)
  end
  return vim.fn.fnamemodify(path, ":.")
end

local function oneline(s) return (tostring(s or ""):gsub("%s*\n%s*", " ")) end

-- token<TAB>description ; token is what Claude Code inserts after @
local function entry(path, lnum, desc)
  return string.format("%s#L%d\t%s", path, lnum, desc)
end

-- Per-project server socket so the shell script can find this nvim.
function M.setup()
  local function start()
    local h = vim.fn.sha256(vim.fn.getcwd()):sub(1, 12)
    local sock = "/tmp/nvim-claude-" .. h .. ".sock"
    if M._sock == sock then return end
    if M._sock then pcall(vim.fn.serverstop, M._sock) end
    pcall(vim.fn.serverstart, sock)
    M._sock = sock
  end
  start()
  vim.api.nvim_create_autocmd("DirChanged", { callback = start })
end

function M.lsp(root, query)
  local out, seen = {}, {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    local bufs = vim.lsp.get_buffers_by_client_id(client.id)
    if bufs[1] and client:supports_method("workspace/symbol") then
      local res = client:request_sync("workspace/symbol", { query = query or "" }, 1000, bufs[1])
      for _, s in ipairs((res and res.result) or {}) do
        local loc = s.location or {}
        local line = loc.range and (loc.range.start.line + 1) or 1
        local path = rel(vim.uri_to_fname(loc.uri), root)
        local kind = vim.lsp.protocol.SymbolKind[s.kind] or "?"
        local key = path .. line .. s.name
        if not seen[key] then
          seen[key] = true
          out[#out + 1] = entry(path, line, string.format("%s %s %s", kind, s.name, s.containerName or ""))
        end
      end
    end
  end
  return table.concat(out, "\n")
end

function M.diag(root)
  local out = {}
  for _, d in ipairs(vim.diagnostic.get()) do
    local name = vim.api.nvim_buf_get_name(d.bufnr)
    if name ~= "" then
      local sev = (vim.diagnostic.severity[d.severity] or "?"):sub(1, 1)
      out[#out + 1] = entry(rel(name, root), d.lnum + 1, "[" .. sev .. "] " .. oneline(d.message))
    end
  end
  return table.concat(out, "\n")
end

function M.qf(root)
  local out = {}
  for _, e in ipairs(vim.fn.getqflist()) do
    if e.bufnr > 0 then
      out[#out + 1] = entry(rel(vim.api.nvim_buf_get_name(e.bufnr), root), math.max(e.lnum, 1), oneline(e.text))
    end
  end
  return table.concat(out, "\n")
end

function M.buf(root)
  local out = {}
  for _, b in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if b.name ~= "" then out[#out + 1] = rel(b.name, root) end
  end
  return table.concat(out, "\n")
end

return M

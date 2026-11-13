-- Show dropbar breadcrumbs in telescope preview windows (grep, lsp references, files, ...)
--
-- Telescope swaps preview buffers with `noautocmd`, so dropbar never attaches on its own.
-- Preview buffers are also unnamed scratch buffers, so dropbar's path source can't be used;
-- we build the path symbols from the filename telescope reports instead.
local M = {}

-- path source that reads the previewed file from a buffer variable
local preview_path_source = {
  get_symbols = function(buf, _, _)
    local path = vim.b[buf].dropbar_preview_path
    if not path or path == '' then
      return {}
    end

    local bar = require 'dropbar.bar'
    local icons = require('dropbar.configs').opts.icons.kinds
    local abs = vim.fs.normalize(vim.fn.fnamemodify(path, ':p'))
    local rel = vim.fn.fnamemodify(abs, ':~:.')
    local parts = vim.split(rel, '/', { trimempty = true })

    local symbols = {}
    local current = abs:sub(1, #abs - #rel)
    for i, part in ipairs(parts) do
      current = vim.fs.joinpath(current, part)
      local is_file = i == #parts
      local icon, icon_hl
      if is_file then
        icon, icon_hl = icons.file_icon(current)
      else
        icon, icon_hl = icons.dir_icon(current)
      end
      table.insert(
        symbols,
        bar.dropbar_symbol_t:new {
          name = part,
          icon = icon,
          icon_hl = icon_hl,
          name_hl = is_file and 'DropBarKindFile' or 'DropBarKindDir',
        }
      )
    end
    return symbols
  end,
}

---Find the (floating) window currently showing `buf`
---@param buf integer
---@return integer?
local function preview_win(buf)
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      return win
    end
  end
end

function M.setup()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TelescopePreviewerLoaded',
    group = vim.api.nvim_create_augroup('dropbar-telescope-preview', { clear = true }),
    callback = function(args)
      local buf = args.buf
      local data = args.data or {}
      local win = preview_win(buf)
      if not win or not data.bufname then
        return
      end

      vim.b[buf].dropbar_preview_path = data.bufname

      local bars = _G.dropbar and _G.dropbar.bars
      if not bars then
        return
      end
      if not rawget(bars[buf], win) then
        local sources = require 'dropbar.sources'
        bars[buf][win] = require('dropbar.bar').dropbar_t:new {
          buf = buf,
          win = win,
          sources = {
            preview_path_source,
            require('dropbar.utils').source.fallback { sources.lsp, sources.treesitter },
          },
        }
      end

      -- `_G.dropbar()` renders the bar for the window being drawn
      vim.wo[win].winbar = '%{%v:lua.dropbar()%}'

      -- telescope moves the cursor to the match after this event fires (and without
      -- triggering CursorMoved), so refresh once the jump has happened
      vim.defer_fn(function()
        local b = rawget(bars, buf) and rawget(bars[buf], win)
        if b and vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
          b:_update()
        end
      end, 30)
    end,
  })
end

return M

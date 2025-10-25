
local M = {}
local macro_file = vim.fn.stdpath('data') .. '/macros_named.json'
local loaded_once = false
local last_loaded_hash = nil

local function read_macros()
  if vim.fn.filereadable(macro_file) == 0 then return {} end
  local content = vim.fn.readfile(macro_file)[1]
  return vim.fn.json_decode(content)
end

local function write_macros(data)
  vim.fn.writefile({ vim.fn.json_encode(data) }, macro_file)
end

local function b64encode(str)
  return vim.fn.system('base64 --wrap=0', str):gsub('%s+$', '')
end

local function b64decode(str)
  return vim.fn.systemlist('base64 --decode', { str })[1]
end

local function file_sha256(path)
  if vim.fn.filereadable(path) == 0 then return nil end
  return vim.fn.system('sha256sum ' .. vim.fn.shellescape(path)):match('^(%w+)')
end

-- Save a macro with a given name and description
function M.save_named(name, reg, description, opts)
  opts = opts or {}
  local data = read_macros()
  local upper = string.upper(reg)
  if data[name] and not opts.force then
    vim.notify('🚫 Macro "' .. name .. '" already exists (register @' .. data[name].register .. ')', vim.log.levels.WARN)
    return
  end

  local val = vim.fn.getreg(reg)
  if val == '' then
    vim.notify('⚠️ Register @' .. reg .. ' is empty, cannot save', vim.log.levels.WARN)
    return
  end

  data[name] = {
    register = upper,
    description = description or "",
    data = b64encode(val),
  }

  vim.fn.setreg(upper, val)  -- make it available immediately
  write_macros(data)
  vim.notify('💾 Saved macro "' .. name .. '" → @' .. upper, vim.log.levels.INFO)
end

-- Load all named macros into their uppercase registers
function M.load_named(opts)
  opts = opts or {}
  local hash = file_sha256(macro_file)
  if loaded_once and not opts.force and hash == last_loaded_hash then
    vim.notify('⚙️ Named macros already loaded — skipping', vim.log.levels.INFO)
    return
  end

  local data = read_macros()
  for name, entry in pairs(data) do
    vim.fn.setreg(entry.register, b64decode(entry.data))
  end
  loaded_once = true
  last_loaded_hash = hash
  vim.notify('🔁 Loaded all named macros into uppercase registers', vim.log.levels.INFO)
end

-- Run a macro by name
function M.run_named(name)
  local data = read_macros()
  local entry = data[name]
  if not entry then
    vim.notify('❌ No macro found with name "' .. name .. '"', vim.log.levels.ERROR)
    return
  end
  vim.cmd('normal @' .. entry.register)
end

-- List macros (for telescope or :messages)
function M.list_named()
  local data = read_macros()
  local lines = {}
  for name, entry in pairs(data) do
    table.insert(lines, string.format("%-20s @%-2s %s", name, entry.register, entry.description or ""))
  end
  vim.fn.setqflist({}, ' ', { title = 'Named Macros', lines = lines })
  vim.cmd('copen')
end
-- === telescope integration ===
function M.telescope_picker()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    vim.notify('❌ Telescope not found', vim.log.levels.ERROR)
    return
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local data = read_macros()
  local items = {}

  for name, entry in pairs(data) do
    table.insert(items, {
      name = name,
      register = entry.register,
      description = entry.description or "",
      content = b64decode(entry.data):gsub("[\r\n]", "⏎"),
    })
  end

  pickers.new({}, {
    prompt_title = '📜 Named Macros',
    finder = finders.new_table {
      results = items,
      entry_maker = function(item)
        return {
          value = item,
          display = string.format("%-20s @%-2s %s", item.name, item.register, item.description),
          ordinal = item.name .. " " .. item.description,
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    previewer = conf.grep_previewer({
      title = 'Macro Contents',
      get_command = function(entry)
        local content = entry.value.content or ''
        local tmpfile = vim.fn.tempname()
        vim.fn.writefile(vim.split(content, "\n"), tmpfile)
        return { 'cat', tmpfile }
      end,
    }),
    attach_mappings = function(_, map)
      map('i', '<CR>', function(bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(bufnr)
        vim.cmd('normal @' .. selection.value.register)
        vim.notify('▶️ Ran macro "' .. selection.value.name .. '" (@' .. selection.value.register .. ')', vim.log.levels.INFO)
      end)
      map('n', '<CR>', function(bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(bufnr)
        vim.cmd('normal @' .. selection.value.register)
        vim.notify('▶️ Ran macro "' .. selection.value.name .. '" (@' .. selection.value.register .. ')', vim.log.levels.INFO)
      end)
      return true
    end,
  }):find()
end

return M

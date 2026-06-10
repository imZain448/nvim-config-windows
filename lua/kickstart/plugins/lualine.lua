return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local c = {
      bg = '#16181a',
      bg_b = '#1e2030',
      fg = '#ffffff',
      dim = '#5a6374',
      blue = '#5ea1ff',
      green = '#5eff6c',
      cyan = '#5ef1ff',
      red = '#ff6e5e',
      yellow = '#f1ff5e',
      pink = '#ff5ef1',
      orange = '#ff9f5e',
      purple = '#bd5eff',
    }

    local theme = {
      -- sections b/c are transparent — only the a/z pills carry color
      normal   = { a = { fg = c.bg, bg = c.blue,   gui = 'bold' }, b = { fg = c.fg,  bg = 'NONE' }, c = { fg = c.dim, bg = 'NONE' } },
      insert   = { a = { fg = c.bg, bg = c.green,  gui = 'bold' }, b = { fg = c.fg,  bg = 'NONE' }, c = { fg = c.dim, bg = 'NONE' } },
      visual   = { a = { fg = c.bg, bg = c.purple, gui = 'bold' }, b = { fg = c.fg,  bg = 'NONE' }, c = { fg = c.dim, bg = 'NONE' } },
      replace  = { a = { fg = c.bg, bg = c.red,    gui = 'bold' }, b = { fg = c.fg,  bg = 'NONE' }, c = { fg = c.dim, bg = 'NONE' } },
      command  = { a = { fg = c.bg, bg = c.yellow, gui = 'bold' }, b = { fg = c.fg,  bg = 'NONE' }, c = { fg = c.dim, bg = 'NONE' } },
      terminal = { a = { fg = c.bg, bg = c.cyan,   gui = 'bold' }, b = { fg = c.fg,  bg = 'NONE' }, c = { fg = c.dim, bg = 'NONE' } },
      inactive = { a = { fg = c.dim, bg = 'NONE' }, b = { fg = c.dim, bg = 'NONE' }, c = { fg = c.dim, bg = 'NONE' } },
    }

    -- reads the active neo-tree source for the given window
    local function current_source()
      local ok, manager = pcall(require, 'neo-tree.sources.manager')
      if not ok then
        return 'filesystem'
      end
      local state = manager.get_state_for_window(vim.api.nvim_get_current_win())
      return state and state.name or 'filesystem'
    end

    local function tab(source_name, label)
      return {
        function()
          return label
        end,
        color = function()
          if current_source() == source_name then
            return { fg = '#16181a', bg = '#5ea1ff', gui = 'bold' }
          else
            return { fg = '#5a6374', bg = '#1e2030' }
          end
        end,
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      }
    end

    -- custom extension: replaces lualine in the neo-tree window with source tabs
    local neo_tree_ext = {
      sections = {
        lualine_a = {
          tab('filesystem', '󰉓 Files'),
          tab('buffers', '󰈚 Buffers'),
          tab('git_status', ' Git'),
        },
      },
      inactive_sections = {
        lualine_a = {
          tab('filesystem', '󰉓 Files'),
          tab('buffers', '󰈚 Buffers'),
          tab('git_status', ' Git'),
        },
      },
      filetypes = { 'neo-tree' },
    }

    require('lualine').setup {
      options = {
        theme = theme,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        globalstatus = false, -- needed so neo-tree gets its own statusline
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = {
          { 'filename', path = 4, color = { fg = c.fg } },
          { 'branch', color = { fg = c.pink, gui = 'bold' } },
        },
        lualine_c = {
          { 'diff', diff_color = { added = { fg = c.green }, modified = { fg = c.yellow }, removed = { fg = c.red } } },
          { 'diagnostics', diagnostics_color = { error = { fg = c.red }, warn = { fg = c.yellow }, info = { fg = c.cyan }, hint = { fg = c.blue } } },
          {
            function()
              return vim.bo.modified and '●' or ''
            end,
            color = { fg = c.red, gui = 'bold' },
          },
          {
            function()
              local reg = vim.fn.reg_recording()
              return reg ~= '' and ('󰑊 Rec @' .. reg) or ''
            end,
            color = { fg = c.orange, gui = 'bold' },
          },
        },
        lualine_x = {
          { 'searchcount', color = { fg = c.cyan } },
          { 'lsp_status', color = { fg = c.blue } },
        },
        lualine_y = {
          { 'filetype', color = { fg = c.purple } },
          { 'progress', color = { fg = c.dim } },
        },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', color = { fg = c.dim } } },
        lualine_x = { { 'location', color = { fg = c.dim } } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { neo_tree_ext, 'lazy', 'quickfix' },
    }
  end,
}

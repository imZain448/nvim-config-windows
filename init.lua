-- See `:help mapleader`
--
--
--
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undodir = vim.fn.expand '~/.undodir' -- Set custom undo directory
-- Set tabs to 4 spaces
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 4 -- Number of visual spaces per TAB
vim.opt.shiftwidth = 4 -- Spaces per indentation
vim.opt.relativenumber = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- NOTE: setting up the foldmethod to true sitter
vim.opt.foldmethod = 'expr'
-- [[ Setting options ]]
-- See `:help vim.o`
--
--
-- NOTE: setting up landing panel header
--

vim.g.dashboard_defualt_executive = 'telescope'
-- vim.g.dashboard_custom_header = {
--     [[░▒▓█▓▒░      ░▒▓████████▓▒░▒▓████████▓▒░▒▓███████▓▒░             ░▒▓██████▓▒░ ░▒▓██████▓▒░ ]],
--     [[░▒▓█▓▒░      ░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░                   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░]],
--     [[░▒▓█▓▒░      ░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░                   ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░]],
--     [[░▒▓█▓▒░      ░▒▓██████▓▒░    ░▒▓█▓▒░   ░▒▓██████▓▒░             ░▒▓█▓▒▒▓███▓▒░▒▓█▓▒░░▒▓█▓▒░]],
--     [[░▒▓█▓▒░      ░▒▓█▓▒░         ░▒▓█▓▒░         ░▒▓█▓▒░            ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░]],
--     [[░▒▓█▓▒░      ░▒▓█▓▒░         ░▒▓█▓▒░         ░▒▓█▓▒░            ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░]],
--     [[░▒▓████████▓▒░▒▓████████▓▒░  ░▒▓█▓▒░  ░▒▓███████▓▒░              ░▒▓██████▓▒░ ░▒▓██████▓▒░ ]],
-- }

-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Stellarium scripts (.ssc / .inc) are ECMAScript/JavaScript. Register their
-- extensions as dedicated filetypes so ts_ls (see its `filetypes` list) attaches
-- and Tree-sitter can map them to the `javascript` parser (see the treesitter
-- config, `vim.treesitter.language.register`).
vim.filetype.add {
  extension = {
    ssc = 'ssc',
    inc = 'inc',
  },
}

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Window resize with larger increments; supports count (e.g. 3<C-w>> = 15 cols)
vim.keymap.set('n', '<C-w><', function()
  vim.cmd(vim.v.count1 * 5 .. 'wincmd <')
end, { desc = 'Resize window left' })
vim.keymap.set('n', '<C-w>>', function()
  vim.cmd(vim.v.count1 * 5 .. 'wincmd >')
end, { desc = 'Resize window right' })
vim.keymap.set('n', '<C-w>-', function()
  vim.cmd(vim.v.count1 * 5 .. 'wincmd -')
end, { desc = 'Resize window shorter' })
vim.keymap.set('n', '<C-w>+', function()
  vim.cmd(vim.v.count1 * 5 .. 'wincmd +')
end, { desc = 'Resize window taller' })

-- NOTE: keymap for opening and closing neo tree
local dapui_filetypes = {
  dapui_scopes = true,
  dapui_breakpoints = true,
  dapui_stacks = true,
  dapui_watches = true,
  dapui_console = true,
  ['dap-repl'] = true,
}
vim.keymap.set('n', '<C-e>', function()
  if dapui_filetypes[vim.bo.filetype] then
    return
  end
  vim.cmd 'Neotree toggle'
end, { desc = 'Toggle Neo Tree' })
vim.keymap.set('n', '<leader>e', function()
  if vim.bo.filetype == 'neo-tree' then
    vim.cmd 'wincmd p'
  else
    vim.cmd 'Neotree focus'
  end
end, { desc = 'Switch focus between Neo Tree and editor' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- Zoom/maximize the current window, tmux-style (prefix z).
-- Opens the current window full-screen in a new tab; press again to restore the
-- original split layout exactly. Skips zooming when there's only one window.
vim.keymap.set('n', '<leader>z', function()
  if vim.t.zoomed then
    vim.cmd 'tabclose'
  elseif vim.fn.winnr '$' > 1 then
    vim.cmd 'tab split'
    vim.t.zoomed = true
  end
end, { desc = '[Z]oom / maximize window (toggle)' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          layout_strategy = 'center',
          path_display = { 'relative' },
        },
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sF', function()
        require('telescope.builtin').find_files {
          hidden = true,
          no_ignore = true,
        }
      end, { desc = 'Find all files (hidden + ignored)' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>so', builtin.lsp_document_symbols, { desc = '[ ] Find symbols in the current file' })
      vim.keymap.set('n', '<leader>sO', builtin.lsp_dynamic_workspace_symbols, { desc = '[ ] Find symbols in the workspace directory' })

      -- NOTE: changing the layout strategy for lsp_symbols

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  {
    'camgraff/telescope-tmux.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope').setup {
        extensions = {
          tmux = {
            -- Optional config
            all_sessions = true, -- show all sessions (not just current one)
            sort_mru = true, -- sort by most recently used
            sort_last_used = true,
            entry_format = 'session: #{session_name}, window: #{window_name}, pane: #{pane_current_command}',
            filter_function = nil, -- custom filter if needed
          },
        },
      }
      -- Load the extension
      require('telescope').load_extension 'tmux'
    end,
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope').load_extension 'dap'
    end,
  },
  -- lazy.nvim
  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {}, -- needed even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        transparent = true,
      }
      -- vim.cmd.colorscheme 'cyberdream'
    end,
  },
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

      -- tell pyright to use conda env's python path if its available
      local conda_prefix = os.getenv 'CONDA_PREFIX'
      local pyright_setting = {}
      if conda_prefix then
        pyright_setting = {
          settings = {
            python = {
              pythonPath = conda_prefix .. '/bin/python',
              venv = conda_prefix,
              venvPath = conda_prefix,
            },
          },
        }
      end

      -- all the language servers configs
      local servers = {
        clangd = {},
        -- nil_ls is a Nix LSP not available on Mason; install via Nix if needed
        -- gopls = {},
        ruff = {},
        pyright = pyright_setting,
        rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --
        jdtls = {
          cmd = { 'jdtls' },
          root_dir = require('lspconfig').util.root_pattern('.git', 'pom.xml'),
          settings = {
            java = {
              home = os.getenv 'JAVA_HOME',
            },
          },
        },
        ts_ls = {
          filetypes = {
            'ssc',
            'inc',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'jsx',
            'tsx',
          },
          settings = {
            javascript = {
              inlayHints = { includeInlayParameterNameHints = 'all', includeInlayVariableTypeHints = true },
            },
            typescript = {
              inlayHints = { includeInlayParameterNameHints = 'all', includeInlayVariableTypeHints = true },
            },
          },
        },

        eslint = {
          filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
          settings = {
            format = false,
          },
        },
        omnisharp = {
          cmd = { 'omnisharp' },
          root_dir = require('lspconfig').util.root_pattern('*.sln', '*.csproj', '.git'),
          settings = {
            omnisharp = {
              enableRoslynAnalyzers = true,
              enableEditorConfigSupport = true,
              organizeImportsOnFormat = true,
              enableDecompilationSupport = true,
            },
          },
        },
        -- lua_ls = {
        --   -- cmd = { ... },
        --   filetypes = { 'lua' },
        --   -- capabilities = {},
        --   settings = {
        --     Lua = {
        --       completion = {
        --         callSnippet = 'Replace',
        --       },
        --       workspace = {
        --         -- 📁 CRITICAL: Adds your entire Neovim config to the workspace library.
        --         -- This allows Lua-LS to index your config and all required modules.
        --         library = {
        --             [vim.fn.stdpath("config")] = true,
        --             -- Include VIMRUNTIME/lua for built-in Neovim API completions
        --             [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        --         },
        --         -- Set to false to avoid checking external libraries, speeding up startup
        --         checkThirdParty = false,
        --     },
        --
        --     runtime = {
        --     -- Tell the language server which version of Lua you're using (most
        --   -- likely LuaJIT in the case of Neovim)
        --   version = 'LuaJIT',
        --   -- Tell the language server how to find Lua modules same way as Neovim
        --   -- (see `:h lua-module-load`)
        --   path = {
        --     'lua/?.lua',
        --     'lua/?/init.lua',
        --   },
        --     },
        --
        --     telemetry = {
        --         enable = false,
        --     },
        --       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        --       -- diagnostics = { disable = { 'missing-fields' } },
        --     },
        --   },
        -- },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'csharpier',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
          ['lua_ls'] = function()
            require('lspconfig').lua_ls.setup {
              -- ... your desired settings (diagnostics, workspace, etc.)
              -- cmd = { ... },
              filetypes = { 'lua' },
              -- capabilities = {},
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                  workspace = {
                    -- 📁 CRITICAL: Adds your entire Neovim config to the workspace library.
                    -- This allows Lua-LS to index your config and all required modules.
                    library = {
                      [vim.fn.stdpath 'config'] = true,
                      -- Include VIMRUNTIME/lua for built-in Neovim API completions
                      [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                    },
                    -- Set to false to avoid checking external libraries, speeding up startup
                    checkThirdParty = false,
                  },

                  runtime = {
                    -- Tell the language server which version of Lua you're using (most
                    -- likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Tell the language server how to find Lua modules same way as Neovim
                    -- (see `:h lua-module-load`)
                    path = {
                      'lua/?.lua',
                      'lua/?/init.lua',
                    },
                  },

                  telemetry = {
                    enable = false,
                  },
                  -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                  -- diagnostics = { disable = { 'missing-fields' } },
                },
              },
            }
          end,
        },
      }

      -- sourcekit-lsp for Xcode projects.
      -- The built-in lspconfig config uses cmd={'sourcekit-lsp'} which resolves to
      -- /usr/bin/sourcekit-lsp (the CLT stub). That stub has no SDK knowledge and
      -- causes "Loading the standard library failed" from sourcekitd.
      -- Fix: override cmd to use xcrun (sets full toolchain env) + explicitly set
      -- SDKROOT so sourcekitd can locate Swift.swiftmodule and friends.
      -- --default-workspace-type buildServer ensures it uses our buildServer.json
      -- immediately without racing against workspace-type auto-detection.
      -- c/cpp removed from filetypes to prevent indexing SPM's cmark C packages.
      -- The built-in config's root_dir, get_language_id, and capabilities all
      -- survive because vim.lsp.config deep-merges; we only override what's listed.
      local sdk = vim.fn.trim(vim.fn.system 'xcrun --show-sdk-path')
      vim.lsp.config('sourcekit', {
        cmd = {
          'xcrun',
          'sourcekit-lsp',
          '--default-workspace-type',
          'buildServer',
        },
        filetypes = { 'swift', 'objc', 'objcpp' },
        cmd_env = {
          DEVELOPER_DIR = '/Applications/Xcode.app/Contents/Developer',
          SDKROOT = sdk,
        },
        settings = {
          sourcekit = {
            inlayHints = {
              variableTypeHints = { enabled = true },
              parameterNameHints = { enabled = 'all' },
              genericParameterHints = { enabled = true },
            },
          },
        },
      })
      vim.lsp.enable 'sourcekit'
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = { 'n', 'v' },
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 1500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        cpp = { 'clang_format' },
        c = { 'clang_format' },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'eslint_d', stop_after_first = true },
        json = { 'prettierd' },
        css = { 'prettierd' },
        html = { 'prettierd' },
        nix = { 'nixfmt' },
        cs = { 'csharpier' },
      },
    },
  },
  { -- do read the installation section in the readme of mini.snippets!
    'echasnovski/mini.snippets',
    dependencies = 'rafamadriz/friendly-snippets',
    event = 'InsertEnter', -- don't depend on other plugins to load...
    -- :h MiniSnippets-examples:
    opts = function()
      local snippets = require 'mini.snippets'
      return { snippets = { snippets.gen_loader.from_lang() } }
    end,
  },
  -- lazy.nvim
  --
  --
  -- AVANTE AI PLUGIN
  -- Code companion AI plugin

  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
    config = function()
      require('render-markdown').setup {
        preset = 'obsidian',
      }
    end,
  },

  -- Other package managers
  -- require('codecompanion').setup {
  -- },

  {
    'echasnovski/mini.diff',
    config = function()
      local diff = require 'mini.diff'
      diff.setup {
        -- Disabled by default
        source = diff.gen_source.none(),
      }
    end,
  },
  { -- do read the installation section in the readme of nvim-cmp!
    'hrsh7th/nvim-cmp',
    main = 'cmp',
    dependencies = { 'abeldekat/cmp-mini-snippets' }, -- this plugin
    event = 'InsertEnter',
    opts = function()
      local cmp = require 'cmp'
      return {
        snippet = {
          expand = function(args) -- mini.snippets expands snippets from lsp...
            local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            insert { body = args.body } -- Insert at cursor
            cmp.resubscribe { 'TextChangedI', 'TextChangedP' }
            require('cmp.config').set_onetime { sources = {} }
          end,
        },
        sources = cmp.config.sources { { name = 'mini_snippets' } },
        mapping = cmp.mapping.preset.insert(), -- more opts...
      }
    end,
  },
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        float = {
          transparent = true,
          solid = true,
        },
      }
      --vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        transparent = true,
        style = 'night',
        styles = {
          comments = { italic = false }, -- Disable italics in comments
          sidebars = 'transparent', -- This targets neo-tree, packer, etc.
          floats = 'transparent', -- (Optional) Makes floating windows transparent too
        },
        lualine_bold = true,
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'

      vim.cmd [[
          hi! FloatBorder guifg=#7aa2f7 guibg=NONE
        ]]
    end,
  },
  -- {
  --   'erl-koenig/theme-hub.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     -- Optional: for themes that use lush (will be notified if a theme requires it)
  --     -- "rktjmp/lush.nvim"
  --   },
  --   config = function()
  --     require('theme-hub').setup {
  --       -- Configuration options (see below)
  --     }
  --   end,
  -- },
  {
    'uhs-robert/oasis.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('oasis').setup {
        transparent = true,
      } -- (see Configuration below for all customization options)
      -- vim.cmd.colorscheme 'oasis-twilight' -- After setup, apply theme (or any style like "oasis-night")
    end,
  },
  -- Using lazy.nvim
  {
    'metalelf0/black-metal-theme-neovim',
    lazy = false,
    priority = 1000,
    config = function()
      require('black-metal').setup {
        -- optional configuration here, e.g.:
        trve = true, -- switch this to false if you want light variants
        theme = 'dark-funeral',
        alt_bg = true,
        transparent = true,
        -- the theme's neo-tree groups use `transparent and nil or c.bg`, which always
        -- resolves to c.bg, so clear those backgrounds explicitly
        highlights = {
          NeoTreeNormal = { bg = 'none' },
          NeoTreeNormalNC = { bg = 'none' },
          NeoTreeEndOfBuffer = { bg = 'none' },
          NeoTreeVertSplit = { bg = 'none' },
          NeoTreeWinSeparator = { bg = 'none' },
        },
      }
      require('black-metal').load()
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  -- Noice.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = { -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` i needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'sa',
          delete = 'sd',
          find = 'sf',
          find_lef = 'sF',
          highlight = 'sh',
          replace = 'sr',
          suffix_last = 'l',
          suffix_next = 'n',
        },
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = true }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',

    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
      },
    },

    config = function()
      require('nvim-treesitter.install').compilers = {
        vim.fn.getenv 'CC',
        'clang',
        'gcc',
        'cl',
      }

      local parsers = {
        'bash',
        --'powershell',
        'c',
        'diff',
        'html',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'python',
        'javascript',
        'typescript',
        'lua',
        'c_sharp',
      }

      require('nvim-treesitter').install(parsers)

      -- Stellarium scripts are JavaScript; drive their highlighting/indent with
      -- the `javascript` parser (registered in vim.filetype.add near the top).
      vim.treesitter.language.register('javascript', { 'ssc', 'inc' })

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)

          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
          selection_modes = {
            ['@function.outer'] = 'V',
            ['@function.inner'] = 'V',
            ['@conditional.outer'] = 'V',
            ['@conditional.inner'] = 'V',
          },
        },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local move = require 'nvim-treesitter-textobjects.move'

      vim.keymap.set({ 'x', 'o' }, 'if', function()
        select.select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Inner Function Body' })

      vim.keymap.set({ 'x', 'o' }, 'af', function()
        select.select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Around Function' })

      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        select.select_textobject('@conditional.inner', 'textobjects')
      end, { desc = 'Inner Conditional Body' })

      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        select.select_textobject('@conditional.outer', 'textobjects')
      end, { desc = 'Around Conditional Block' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next Function/Method Start' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous Function/Method Start' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']I', function()
        move.goto_next_start('@conditional.outer', 'textobjects')
      end, { desc = 'Next Conditional Block' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[I', function()
        move.goto_previous_start('@conditional.outer', 'textobjects')
      end, { desc = 'Previous Conditional Block' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']i', function()
        move.goto_next('@loop.outer', 'textobjects')
      end, { desc = 'Next Loop Part' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[i', function()
        move.goto_previous('@loop.outer', 'textobjects')
      end, { desc = 'Previous Loop Part' })
    end,
  },
  -- {
  --  'nvim-treesitter/nvim-treesitter-context',
  -- },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },
  -- time-machine.lua
  {
    'y3owk1n/time-machine.nvim',
    version = '*', -- remove this if you want to use the `main` branch
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.
  --
  --
  --
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        -- Defaults
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        per_filetype = {
          ['html'] = {
            enable_close = false,
          },
        },
      }
    end,
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = false,
    config = function()
      require('nvim-web-devicons').setup {}
    end,
  }, -- not strictly required, but recommended
  { 'kmontocam/nvim-conda', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'tpope/vim-surround',
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabed = true,
        },
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        '<leader><leader>s',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        '<leader><leader>S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    config = function()
      local dropbar_api = require 'dropbar.api'
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

      -- breadcrumbs in telescope preview windows (grep, lsp references, ...)
      require('utils.dropbar_telescope').setup()

      -- transparent dropbar background
      vim.api.nvim_set_hl(0, 'WinBar', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'WinBarNC', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DropBar', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DropBarCurrentContext', { bg = 'NONE' })
    end,
  },
  -- NOTE: -- add new plugins above ☝️

  -- custom claude file suggestion plugin
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.xcodebuild',
  require 'kickstart.plugins.telescope-undo',
  -- require 'kickstart.plugins.easymotion',
  require 'kickstart.plugins.autoclose',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  -- require 'kickstart.plugins.avante',
  require 'kickstart.plugins.dashboard',
  -- require 'kickstart.plugins.obsidian',
  require 'kickstart.plugins.harpoon',
  require 'kickstart.plugins.lualine',
  require 'kickstart.plugins.nvimdap',
  require 'kickstart.plugins.csharp',
  require 'kickstart.plugins.undotree',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- claude custom file suggestion
require('claude_at').setup()

-- NOTE: better persistent macros

local macros = require 'utils.macros'

vim.api.nvim_create_user_command('SaveNamedMacro', function(opts)
  local args = vim.split(opts.args, '%s+')
  local name = args[1]
  local reg = args[2] or 'a'
  local desc = table.concat(vim.list_slice(args, 3), ' ')
  macros.save_named(name, reg, desc)
end, { nargs = '+' })

vim.api.nvim_create_user_command('LoadNamedMacros', function()
  macros.load_named()
end, {})

vim.api.nvim_create_user_command('RunMacro', function(opts)
  macros.run_named(opts.args)
end, {
  nargs = 1,
  complete = function()
    return vim.tbl_keys(require('utils.macros').list_all_names())
  end,
})

vim.api.nvim_create_user_command('ListMacros', function()
  macros.list_named()
end, {})

vim.keymap.set('n', '<leader>sm', require('utils.macros').telescope_picker, { desc = '[S]earch: Named Macros' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- NOTE: Harpoon keymaps - blazing fast file hopping
local harpoon = require 'harpoon'
vim.keymap.set('n', '<leader>ha', function()
  harpoon:list():add()
end, { desc = '[Harpoon] add the current file to quick access list' })
vim.keymap.set('n', '<leader>he', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = '[Harpoon] Toggle quick access menu' })

vim.keymap.set('n', '<leader>h1', function()
  harpoon:list():select(1)
end, { desc = '[Harpoon] select file 1' })
vim.keymap.set('n', '<leader>h2', function()
  harpoon:list():select(2)
end, { desc = '[Harpoon] select file 2' })
vim.keymap.set('n', '<leader>h3', function()
  harpoon:list():select(3)
end, { desc = '[Harpoon] select file 3' })
vim.keymap.set('n', '<leader>h4', function()
  harpoon:list():select(4)
end, { desc = '[Harpoon] select file 4' })
vim.keymap.set('n', '<leader>h5', function()
  harpoon:list():select(5)
end, { desc = '[Harpoon] select file 5' })
vim.keymap.set('n', '<leader>h6', function()
  harpoon:list():select(6)
end, { desc = '[Harpoon] select file 6' })
vim.keymap.set('n', '<leader>h7', function()
  harpoon:list():select(7)
end, { desc = '[Harpoon] select file 7' })
vim.keymap.set('n', '<leader>h8', function()
  harpoon:list():select(8)
end, { desc = '[Harpoon] select file 8' })
vim.keymap.set('n', '<leader>h9', function()
  harpoon:list():select(9)
end, { desc = '[Harpoon] select file 9' })

vim.keymap.set('n', '<leader>hk', function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local list = harpoon:list()
  for i, item in ipairs(list.items) do
    if item.value == buf_name or vim.fn.fnamemodify(item.value, ':p') == buf_name then
      list:remove_at(i)
      break
    end
  end
end, { desc = '[Harpoon] drop current file from quick menu' })

vim.keymap.set('n', '<leader>hc', function()
  harpoon:list():clear()
end, { desc = '[Harpoon] empty the quick access list' })
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<leader>hP', function()
  harpoon:list():prev()
end, { desc = '[Harpoon] move to the previous file in the quick menu' })
vim.keymap.set('n', '<leader>hN', function()
  harpoon:list():next()
end, { desc = '[Harpoon] move to the next file in the quick menu' })

vim.keymap.set('n', '<leader>H1', function()
  harpoon:list():remove_at(1)
end, { desc = '[Harpoon] drop file at index 1' })

vim.keymap.set('n', '<leader>H2', function()
  harpoon:list():remove_at(2)
end, { desc = '[Harpoon] drop file at index 2' })

vim.keymap.set('n', '<leader>H3', function()
  harpoon:list():remove_at(3)
end, { desc = '[Harpoon] drop file at index 3' })

vim.keymap.set('n', '<leader>H4', function()
  harpoon:list():remove_at(4)
end, { desc = '[Harpoon] drop file at index 4' })

vim.keymap.set('n', '<leader>H5', function()
  harpoon:list():remove_at(5)
end, { desc = '[Harpoon] drop file at index 5' })
--
--: Aavnate keybindings AI assistant
--
-- vim.keymap.set('n', '<leader>Ac', function()
--     local avante_types = { 'Avante', 'AvanteInput', 'AvanteSelectedFiles', 'AvanteSelectedCode' }
--     local to_close = {}
--
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--         local buf = vim.api.nvim_win_get_buf(win)
--         local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
--         if vim.tbl_contains(avante_types, ft) then
--             table.insert(to_close, win)
--         end
--     end
--
--     for _, win in ipairs(to_close) do
--         pcall(vim.api.nvim_win_close, win, true)
--     end
-- end, { desc = 'Avante: Close Avante Sidebar & Chat' })

-- vim.keymap.set('n', '<leader>Ao', '<cmd>AvanteChat<CR>', { desc = 'Avante: Open Avante Chat' })
-- vim.keymap.set('n', '<leader>An', '<cmd>AvanteChatNew<CR>', { desc = 'Avante: Open Avante New Chat' })
-- NOTE: page jump keybindings
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')
--
-- NOTE: keybindings for todo comments
vim.keymap.set(
  'n',
  '<leader>sT', -- Choose your preferred key sequence (e.g., <leader>s then T)
  '<cmd>TodoTelescope keywords=TODO,FIXME<cr>',
  { desc = 'Todo/Fixme (Telescope)' }
)

vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = 'All Todos (Telescope)' })

-- NOTE: Diagnostics keybindings
vim.keymap.set('n', '<leader>id', function()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  vim.diagnostic.reset(nil, 0) -- resets all
  -- or filter to remove just current line's diagnostics
  vim.diagnostic.setqflist {
    severity = { min = vim.diagnostic.severity.ERROR },
    filter = function(d)
      return d.lnum ~= line
    end,
  }
end, { desc = 'Hide diagnostics on current line' })

vim.keymap.set('n', '<leader>sa', function()
  vim.lsp.buf.code_action()
end, { noremap = true, silent = true, desc = '[Search] for Code actions' })

vim.keymap.set('v', '<leader>sa', function()
  vim.lsp.buf.range_code_action()
end, { noremap = true, silent = true, desc = '[Search] for Code actions in the selected range' })

-- NOTE: Terminal key bindings
vim.keymap.set('n', '<leader>tn', '<cmd>term powershell.exe<CR>', { desc = '[Terminal] - open a powershell terminal' })

-- NOTE: for jumping with treesitter context (better then inbuilt <leader>]])
vim.keymap.set('n', '[n', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true })

-- NOTE: tmux navigaotr keybindings
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'go to left window' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'go to right window' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'go to Down window' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'go to Up window' })

-- NOTE: tmux telescope config

vim.keymap.set('n', '<leader>tw', '<cmd>Telescope tmux windows<CR>', { desc = '[TMUX TELESCOPE] Find tmux window' })

vim.keymap.set('n', '<leader>tp', '<cmd>Telescope tmux panes<CR>', { desc = '[TMUX TELESCOPE] Find tmux pane' })

vim.keymap.set('n', '<leader>ts', '<cmd>Telescope tmux sessions<CR>', { desc = '[TMUX TELESCOPE] Find tmux session' })

-- NOTE: noice

vim.keymap.set('n', '<leader>sN', '<cmd>Noice<CR>', { desc = '[ ] show notification' })

-- NOTE: keybing for case conversion
vim.keymap.set('x', '<leader>cc', function()
  vim.cmd [[
    '<,'>s/\v( |_)(\a)/\u\2/g
    '<,'>s/\v^(\a)/\l\1/
  ]]
end, { desc = 'Convert selection to camelCase' })

vim.keymap.set('x', '<leader>cp', function()
  vim.cmd [[
    '<,'>s/\v( |_)(\a)/\u\2/g
    '<,'>s/\v^(\a)/\u\1/
  ]]
end, { desc = 'Convert selection to PascalCase' })

-- Convert space/snake_case → camelCase for the selected text
-- vim.keymap.set('x', '<leader>cc', function()
--   -- Run both substitutions on the visual selection
--   vim.cmd([[
--     '<,'>s/[ _]\(.\)/\U\1/g
--     '<,'>s/^\(.\)/\L\1/
--   ]])
-- end, { desc = 'Convert selection to camelCase' })
--
-- vim.keymap.set('x', '<leader>cp', function()
--   vim.cmd([[
--     '<,'>s/[ _]\(.\)/\U\1/g
--     '<,'>s/^\(.\)/\U\1/
--   ]])
-- end, { desc = 'Convert selection to PascalCase' })
--
vim.keymap.set('x', '<leader>cs', function()
  vim.cmd [[
    '<,'>s/\([A-Z]\)/_\L\1/g
    '<,'>s/^_//
    '<,'>s/ /_/g
  ]]
end, { desc = 'Convert selection to snake_case' })

-- NOTE: saving custom snippets

vim.keymap.set('v', '<leader>gs', function()
  local ls = require 'luasnip'
  local text = table.concat(vim.fn.getline("'<", "'>"), '\n')
  local ft = vim.bo.filetype

  local snippet_trigger = vim.fn.input 'Trigger: '
  local snippet_name = vim.fn.input 'Snippet name: '

  local snippet = string.format(
    [[
s("%s", {
  t(%q)
}),
]],
    snippet_trigger,
    text
  )

  -- Try to get LuaSnip’s configured snippet paths
  local loader = require 'luasnip.loaders.from_lua'
  local base_paths = loader.get_snippet_filetypes and loader.get_snippet_filetypes() or {}

  -- Try to find an existing LuaSnip snippet path, otherwise fallback
  local default_path = (ls.config and ls.config.snippet_path) or (os.getenv 'HOME' .. '/.config/nvim/LuaSnip')

  -- if you used require("luasnip.loaders.from_lua").lazy_load({ paths = "..." })
  -- you can read that here instead:
  local ok, configured_paths = pcall(function()
    return loader._load_paths
  end)
  local base_path = (ok and configured_paths and configured_paths[1]) or default_path

  -- ensure directory exists
  vim.fn.mkdir(base_path, 'p')

  local path = string.format('%s/%s.lua', base_path, ft)
  vim.fn.writefile({ snippet }, path, 'a')
  print('✅ Snippet added to: ' .. path)

  -- optional: reload snippets immediately
  pcall(function()
    loader.load { paths = base_path }
  end)
end, { desc = 'Save visual selection as snippet' })

-- NOTE: copy path and directories
-- Helper function to copy path and notify
local function copy_path(expansion)
  local path = vim.fn.expand(expansion)
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO, { title = 'Clipboard' })
end

-- 1. Relative Path (e.g., src/main.lua)
vim.keymap.set('n', '<leader>cr', function()
  copy_path '%'
end, { desc = 'Copy relative path' })

-- 2. Absolute Path (e.g., /home/user/project/src/main.lua)
vim.keymap.set('n', '<leader>ca', function()
  copy_path '%:p'
end, { desc = 'Copy absolute path' })

-- 3. Filename Only (e.g., main.lua)
vim.keymap.set('n', '<leader>cf', function()
  copy_path '%:t'
end, { desc = 'Copy filename' })

-- 4. Directory Path (e.g., /home/user/project/src)
vim.keymap.set('n', '<leader>cd', function()
  copy_path '%:p:h'
end, { desc = 'Copy directory path' })

return {
  'mfussenegger/nvim-dap-python',
  dependencies = {
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local telescope = require 'telescope'

    -- ── Swift / iOS DAP (xcodebuild.nvim, Xcode 16+ built-in LLDB) ──────
    -- xcodebuild.nvim registers its own adapter for Xcode targets;
    -- setup() only accepts an optional loadBreakpoints boolean (default true)
    local ok, xcdap = pcall(require, 'xcodebuild.integrations.dap')
    if ok then
      xcdap.setup() -- loads breakpoints from xcodebuild on attach
    end

    -- plain Swift Package Manager projects (no Xcode target) use lldb-dap
    -- which ships with Xcode 16+ at the path below
    local lldb_dap = '/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap'
    if vim.fn.executable(lldb_dap) == 1 then
      dap.adapters.swift = {
        type = 'executable',
        command = lldb_dap,
      }
      dap.configurations.swift = {
        {
          name       = 'Launch Swift (SPM debug build)',
          type       = 'swift',
          request    = 'launch',
          program    = function()
            vim.fn.system 'swift build'
            local cwd  = vim.fn.getcwd()
            local name = vim.fn.fnamemodify(cwd, ':t')
            return vim.fn.input('Executable: ', cwd .. '/.build/debug/' .. name, 'file')
          end,
          cwd        = '${workspaceFolder}',
          stopOnEntry = false,
          args       = {},
        },
      }
    end
    -- ─────────────────────────────────────────────────────────────────────

    -- Custom launch config for FastAPI (uvicorn)
    local function load_project_dap_config()
      -- NOTE: your local launch config should be at this path in the root dir of the project
      local config_file = vim.fn.getcwd() .. '/.nvim/dap.json'

      if vim.fn.filereadable(config_file) == 1 then
        local ok, content = pcall(vim.fn.readfile, config_file)
        if not ok then
          return
        end

        local decoded = vim.fn.json_decode(content)
        if not decoded or not decoded.configurations then
          return
        end

        for _, cfg in ipairs(decoded.configurations) do
          if cfg.type == 'python' and cfg.python then
            -- override the adapter to use this interpreter
            dap.adapters.python = {
              type = 'executable',
              command = cfg.python,
              args = { '-m', 'debugpy.adapter' },
              option = {
                source_filetype = 'python',
              },
            }
            require('dap-python').setup(cfg.python) -- NOTE: setting the python path from the launch configs
          end
        end

        dap.configurations.python = decoded.configurations
      end
    end
    -- Call when entering a Python project
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*.py',
      callback = load_project_dap_config,
    })

    -- don’t close automatically
    -- dap.listeners.before.event_terminated["dapui_config"] = function() require("dapui").close() end
    -- dap.listeners.before.event_exited["dapui_config"]     = function() require("dapui").close() end
    -- DAP UI setup
    dapui.setup()

    -- Auto-open/close dap-ui and manage neo-tree
    local neotree_was_open = false
    dap.listeners.after.event_initialized['dapui_config'] = function()
      -- remember if neo-tree was open and close it
      for _, win in pairs(vim.api.nvim_list_wins()) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'neo-tree' then
          neotree_was_open = true
          break
        end
      end
      if neotree_was_open then
        vim.cmd 'Neotree close'
      end
      dapui.open()
    end
    local function on_dap_close()
      dapui.close()
      if neotree_was_open then
        vim.cmd 'Neotree show'
        neotree_was_open = false
      end
    end
    dap.listeners.before.event_terminated['dapui_config'] = on_dap_close
    dap.listeners.before.event_exited['dapui_config'] = on_dap_close
    -- dap.listeners.before.event_terminated['dapui_config'] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited['dapui_config'] = function()
    --   dapui.close()
    -- end
    -- NOTE: Helper: jump to dap-ui window by filetype, opening the UI first if needed
    local function focus_dapui(ft)
      local function try_focus()
        for _, win in pairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == ft then
            vim.api.nvim_set_current_win(win)
            return true
          end
        end
        return false
      end

      if not try_focus() then
        dapui.open()
        vim.schedule(function()
          if not try_focus() then
            vim.notify('No DAP UI window with filetype ' .. ft, vim.log.levels.WARN)
          end
        end)
      end
    end
    --
    -- Keymaps
    vim.keymap.set('n', '<leader>dd', function()
      dap.continue()
    end, { desc = 'DAP Start/Continue' })
    vim.keymap.set('n', '<leader>dq', function()
      dap.terminate()
      dapui.close()
    end, { desc = 'DAP Quit' })
    vim.keymap.set('n', '<leader>dr', function()
      dap.terminate()
      dap.run_last()
    end, { desc = 'DAP Restart Last' })

    vim.keymap.set('n', '<leader>dh', function()
      dap.step_over()
    end, { desc = 'DAP Step Over' })
    vim.keymap.set('n', '<leader>dk', function()
      dap.step_into()
    end, { desc = 'DAP Step Into' })
    vim.keymap.set('n', '<leader>dj', function()
      dap.step_out()
    end, { desc = 'DAP Step Out' })
    vim.keymap.set('n', '<Leader>b', function()
      dap.toggle_breakpoint()
    end, { desc = 'DAP Toggle Breakpoint' })
    vim.keymap.set('n', '<Leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'DAP Conditional Breakpoint' })

    -- telescope keymaps for dap
    vim.keymap.set('n', '<leader>dv', telescope.extensions.dap.variables, { desc = 'DAP Variables' })
    vim.keymap.set('n', '<leader>df', telescope.extensions.dap.frames, { desc = 'DAP Frames' })
    vim.keymap.set('n', '<leader>dc', telescope.extensions.dap.commands, { desc = 'DAP Commands' })
    vim.keymap.set('n', '<leader>dl', telescope.extensions.dap.list_breakpoints, { desc = 'DAP Breakpoints' })

    vim.keymap.set('n', '<leader>ds', function()
      focus_dapui 'dapui_scopes'
    end, { desc = 'DAP: Focus Scopes' })
    vim.keymap.set('n', '<leader>db', function()
      focus_dapui 'dapui_breakpoints'
    end, { desc = 'DAP: Focus Breakpoints' })
    vim.keymap.set('n', '<leader>dt', function()
      focus_dapui 'dapui_stacks'
    end, { desc = 'DAP: Focus Stacks' })
    vim.keymap.set('n', '<leader>dw', function()
      focus_dapui 'dapui_watches'
    end, { desc = 'DAP: Focus Watches' })
    vim.keymap.set('n', '<leader>dr', function()
      focus_dapui 'dap-repl'
    end, { desc = 'DAP: Focus REPL' })
    vim.keymap.set('n', '<leader>do', function()
      focus_dapui 'dapui_console'
    end, { desc = 'DAP: Focus Console' })
  end,
}

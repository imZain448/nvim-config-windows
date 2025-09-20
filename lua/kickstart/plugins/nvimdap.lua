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

    -- Auto-open/close dap-ui
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    -- dap.listeners.before.event_terminated['dapui_config'] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited['dapui_config'] = function()
    --   dapui.close()
    -- end
    -- NOTE: Helper: jump to dap-ui window by filetype
    local function focus_dapui(ft)
      for _, win in pairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == ft then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
      vim.notify('No DAP UI window with filetype ' .. ft, vim.log.levels.WARN)
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
  end,
}

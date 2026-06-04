return {
  {
    'jay-babu/mason-nvim-dap.nvim',
    ft = { 'cs' },
    dependencies = {
      'mason-org/mason.nvim',
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = { 'netcoredbg' },
        handlers = {},
      }

      dap.adapters.coreclr = {
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'Launch .NET',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
        {
          -- Unity Editor must be running with "Allow debugging" enabled in Build Settings
          type = 'coreclr',
          name = 'Attach to Unity Editor',
          request = 'attach',
          processId = require('dap.utils').pick_process,
        },
      }
    end,
  },
}

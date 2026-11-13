return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
    'mfussenegger/nvim-dap',           -- required for DAP integration
  },
  config = function()
    require('xcodebuild').setup {
      integrations = {
        nvim_dap = {
          enabled = true,
          terminate_debugger_on_stop = true,
        },
      },
    }

    -- xcodebuild keymaps
    local xb = require 'xcodebuild.actions'
    vim.keymap.set('n', '<leader>xb', xb.build,               { desc = 'Xcode Build' })
    vim.keymap.set('n', '<leader>xr', xb.run,                 { desc = 'Xcode Run' })
    vim.keymap.set('n', '<leader>xt', xb.run_tests,           { desc = 'Xcode Run Tests' })
    vim.keymap.set('n', '<leader>xT', xb.run_selected_tests,  { desc = 'Xcode Run Selected Tests' })
    vim.keymap.set('n', '<leader>xp', xb.select_project,      { desc = 'Xcode Select Project' })
    vim.keymap.set('n', '<leader>xs', xb.select_scheme,       { desc = 'Xcode Select Scheme' })
    vim.keymap.set('n', '<leader>xd', xb.select_device,       { desc = 'Xcode Select Device' })
  end,
}

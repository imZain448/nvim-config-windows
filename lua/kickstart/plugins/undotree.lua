return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', '<Cmd>UndotreeToggle<CR>', desc = 'Toggle Undo Tree' },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2       -- tree on left, diff below
    vim.g.undotree_SplitWidth = 35
    vim.g.undotree_SetFocusWhenToggle = 1 -- focus undotree when opened
  end,
}

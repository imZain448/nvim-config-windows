return {
  'mbbill/undotree',
  config = function()
    vim.g.undotree_WindowLayout    = 3    -- tree on right, diff below tree
    vim.g.undotree_SplitWidth      = 35
    vim.g.undotree_SetFocusWhenToggle = 1 -- focus undotree when opened

    -- <leader><leader>u → toggle undotree
    vim.keymap.set('n', '<leader><leader>u', '<Cmd>UndotreeToggle<CR>',
      { desc = 'Toggle Undo Tree', silent = true })

    -- <leader><leader>f → switch focus: undotree → editor, or editor → undotree
    vim.keymap.set('n', '<leader><leader>f', function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft  = vim.api.nvim_get_option_value('filetype', { buf = buf })
        if ft == 'undotree' or ft == 'diff' then
          if vim.api.nvim_get_current_win() == win then
            -- currently in undotree → jump back to previous editor window
            vim.cmd 'wincmd p'
          else
            -- currently in editor → focus undotree
            vim.api.nvim_set_current_win(win)
          end
          return
        end
      end
      -- undotree not open, open and focus it
      vim.cmd 'UndotreeToggle'
    end, { desc = 'Switch focus: editor ↔ Undo Tree', silent = true })
  end,
}

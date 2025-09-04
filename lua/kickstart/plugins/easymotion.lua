return {
  'easymotion/vim-easymotion',
  keys = {
    { '<Leader><Leader>w', '<Plug>(easymotion-w)' },
    { '<Leader><Leader>b', '<Plug>(easymotion-b)' },
    { '<Leader><Leader>f', '<Plug>(easymotion-f)' },
    { '<Leader><Leader>l', '<Plug>(easymotion-lineforward)' },
    { '<Leader><Leader>j', '<Plug>(easymotion-j)' },
    { '<Leader><Leader>F', '<Plug>(easymotion-F)', desc = 'EasyMotion: Find character backward' },
    { '<Leader><Leader>s', '<Plug>(easymotion-s)', desc = 'EasyMotion: Jump to anywhere' },
    { '<Leader><Leader>h', '<Plug>(easymotion-backward-word)', desc = 'EasyMotion: Backward word' },
    { '<Leader><Leader>e', '<Plug>(easymotion-end-of-word)', desc = 'EasyMotion: End of word' },
    { '<Leader><Leader>/', '<Plug>(easymotion-sn)', desc = 'EasyMotion: End of word' },
  },
}

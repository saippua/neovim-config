return {
  'tpope/vim-fugitive',
  dependencies = {
    'akinsho/git-conflict.nvim',
    'lewis6991/gitsigns.nvim'
  },
  version = "*",
  config = function()
    require('git-conflict').setup()
    require('gitsigns').setup()
  end,
}

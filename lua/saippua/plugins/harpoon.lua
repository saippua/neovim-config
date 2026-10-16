return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    vim.keymap.set('n', '<leader>h', require('harpoon.ui').toggle_quick_menu, {})
    vim.keymap.set('n', '<leader>a', require('harpoon.mark').add_file, {})
    require('harpoon').setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      }
    })
  end
}

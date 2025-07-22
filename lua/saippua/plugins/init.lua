return {
  'rgarver/Kwbd.vim',
  'tpope/vim-surround',
  { 'mfussenegger/nvim-dap' },
  { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end },

  --- NOTE::::: vim-illuminate seems to cause crazy lag on larger files (50kb+)
  --Hopefully large_file_cutoff fixes this problem.
  {
    'RREthy/vim-illuminate',
    config = function()
      require('illuminate').configure( {
        modes_allowlist = { 'n' },
        min_count_to_hightlight = 2,
        delay=1000,
        large_file_cutoff=1000,
        providers = {
          'treesitter',
        },
      })
    end,
    init = function()
      vim.api.nvim_set_hl(0, "IlluminatedWordText",  { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead",  { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end
  },

  -- {
  --   'folke/which-key.nvim',
  --   config = function()
  --     vim.o.timeout=true
  --     vim.o.timeoutlen = 300
  --     require("which-key").setup({
  --     })
  --   end,
  -- },


  -- Languages
  'NoahTheDuke/vim-just',
}

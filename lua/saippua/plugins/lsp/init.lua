return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'hrsh7th/nvim-cmp' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    require('saippua.plugins.lsp.powershell').setup()
    require('saippua.plugins.lsp.yaml').setup()
    require('saippua.plugins.lsp.groovy').setup()
    require('saippua.plugins.lsp.cmake').setup()
    require('saippua.plugins.lsp.clangd').setup()
  end
}

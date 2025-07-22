return {
  'williamboman/mason.nvim',
  dependecies = {
    { 'williamboman/mason-lspconfig.nvim' },
  },
  build = ":MasonUpdate",
  config = function()
    require("mason").setup {
      ui = {
        check_outdated_packages_on_open = false,
      },
    }
    require("mason-lspconfig").setup {
      ensure_installed = { "lua_ls" }
    }
  end
}

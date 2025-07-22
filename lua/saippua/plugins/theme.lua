return {
  'folke/styler.nvim',
  dependencies = {
    { 'rebelot/kanagawa.nvim' },
    { 'olimorris/onedarkpro.nvim' },
  },

  config = function ()
    require("styler").setup({
      themes = {}
    })
    -- require("styler").setup({
      -- themes = {
      --   terminal = "onedark_dark",
      -- },
    -- })
    -- require("kanagawa").setup({
    --   theme = "wave",
    --   background = {
    --     dark = "wave",
    --     light = "lotus",
    --   },
    -- })
    --
    -- local i = 0
    -- vim.api.nvim_create_autocmd({ "BufEnter", "TermOpen" }, {
    --   callback = function(args)
    --     if (vim.bo.buftype == 'terminal') then
    --       require("styler").set_theme(0, {
    --         colorscheme = "onedark_dark",
    --       })
    --     end
    --     i = i + 1
    --   end
    -- })
    -- vim.api.nvim_create_autocmd({ "BufEnter", "TermOpen" }, {
    --   callback = function(args)
    --     if (args.event == "TermOpen" or vim.bo.buftype == 'terminal') then
    --       require("styler").set_theme(0, {
    --         colorscheme = "onedark_dark",
    --       })
    --     end
    --     -- for i in pairs(args) do
    --     --   print(i)
    --     -- end
    --     -- print(args.event)
    --   end
    -- })
  end,

  init = function()
    vim.cmd('colorscheme kanagawa-wave')
  end
}

return {
  'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowGreen",
      "RainbowBlue",
      "RainbowCyan",
      "RainbowMagenta",
      "RainbowYellow",
      "RainbowKey",
    }

    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#4f2427" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#344229" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#27455e" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#245248" })
        vim.api.nvim_set_hl(0, "RainbowMagenta", { fg = "#4c2f54" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#474325" })
        vim.api.nvim_set_hl(0, "RainbowKey", { fg = "#353535" })
  end)
    require('ibl').setup {
      indent = {
        highlight = highlight,
        char = "▏",
      },
      scope = { enabled = false },
    }
  end,
}

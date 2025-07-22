return {
  'sindrets/diffview.nvim',
  -- dependencies = {
  --   'nvim-tree/nvim-web-devicons'
  -- },

  config = function()

    local actions = require("diffview.actions")
    require('diffview').setup({
      hooks = {
        diff_buf_read = function(bufnr)
          -- Disable folding in files (except really big files)
          vim.opt_local.foldminlines = 3000
        end,
      },
      view = {
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_mixed",
          disable_diagnostics = true,   -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = true,           -- See |diffview-config-view.x.winbar_info|
        },
      },
      keymaps = {
        view = {
          { "n", "<C-p>", "[c", { desc = "Go to previous" }},
          { "n", "<C-n>", "]c", { desc = "Go to next" }},
          { "n", "<C-l>",  actions.conflict_choose("ours"), },
          { "n", "<C-h>",  actions.conflict_choose("theirs"), },
          { "n", "<C-k>",  actions.conflict_choose("all"), },
          { "n", "<C-j>",  actions.conflict_choose("none"), },
          { "n", "<C-m>", function() print("TODO: make this!") end, { desc = "Open the current commit message" }},
        },
      },
      use_icons = false,
    })

  end
}

-- TODO convert this to lazy.nvim

return {
  'L3MON4D3/LuaSnip',
  config = function()
    require('luasnip.loaders.from_snipmate').lazy_load()
    require('luasnip.loaders.from_lua').load({paths = "~/.config/nvim/snippets"})
    require('luasnip').config.setup({
      history = false,
      enable_autosnippets = true,
      -- snip_env = 

    })

    local luasnip = require('luasnip')
    
    local in_snip = luasnip.choice_active()

    local jf = function()
      local jmp = luasnip.locally_jumpable(1)
      print(jmp)
      if jmp then luasnip.jump(1) end
    end

    local jb = function()
      local jmp = luasnip.locally_jumpable(-1)
      print(jmp)
      if jmp then luasnip.jump(-1) end
    end
    -- vim.keymap.set('i', '<CR>', function() if luasnip.choice_active() then jf else , { remap = false })
    -- vim.keymap.set('s', '<CR>', jf, { remap = false })
    -- vim.keymap.set('i', '<C-p>', jb, { remap = false })
    -- vim.keymap.set('s', '<C-p>', jb, { remap = false })

    vim.api.nvim_create_user_command("Snippets", function() require('luasnip.loaders').edit_snippet_files({}) end, {})

    local ls = require("luasnip")
    local i = ls.insert_node
    local t = ls.text_node
    local s = ls.snippet

    ls.add_snippets("lua", {
      s("ternary", {
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
      })
    })
  end
}

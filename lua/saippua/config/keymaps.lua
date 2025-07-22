-- Removing defaults (these are redefined later with different binds)
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'grr')

-- Generic
vim.keymap.set({"n", "v"}, "y", '"+y', { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "x", '"+x', { noremap = true, silent = true })
vim.keymap.set("n", "p", '"+p', { noremap = true, silent = true })
vim.keymap.set("n", "P", '"+P', { noremap = true, silent = true })
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })
vim.keymap.set("v", "<", '<gv', { noremap = true, silent = true })
vim.keymap.set("v", ">", '>gv', { noremap = true, silent = true })

vim.keymap.set('n', '<C-j>', '5j', {noremap=true}) -- More speeeeeed!
vim.keymap.set('n', '<C-k>', '5k', {noremap=true})

-- "Zoom-mode" maximize current pane with Alt-z
vim.keymap.set({"n", "v"}, "<A-z>", "<C-w>_<C-w>|", {noremap = true, silent = true})
vim.keymap.set("i", "<A-z>", "<ESC><C-w>_<C-w>|i", {noremap = true, silent = true})
vim.keymap.set("t", "<A-z>", "<C-\\><C-n><C-w>_<C-w>|i", {noremap = true, silent = true})

-- Telescope
local ts_builtin = require('telescope.builtin')
local ts_live_grep_args = require('telescope').extensions.live_grep_args

vim.keymap.set('n', '<leader>pf', function() ts_builtin.find_files{ hidden = true } end,                      { noremap = true, desc = "Find File: Fuzzy find file in project."})
vim.keymap.set('n', '<leader>PF', function() ts_builtin.find_files{ hidden = true, no_ignore = true } end,    { noremap = true, desc = "Find File: Fuzzy find all files in project."})
vim.keymap.set('n', '<leader>ps', function() ts_live_grep_args.live_grep_args() end,                             { noremap = true, desc = "Find String: Fuzzy find string in project files." })
vim.keymap.set('n', '<leader>PS', function() ts_live_grep_args.live_grep_args{ vimgrep_arguments = vga } end,    { noremap = true, desc = "Find String: Fuzzy find string in all project files." })
vim.keymap.set('n', '<leader>va', function() ts_builtin.diagnostics { bufnr=0 } end,    { noremap = true, desc = "Show Diagnostics for current buffer." })
vim.keymap.set('n', '<leader>fg', ts_builtin.git_files,      { noremap = true, desc = "Find Git: Fuzzy find file in git." })
vim.keymap.set('n', '<leader>gq', ts_builtin.quickfix,       { noremap = true, desc = "Show quickfix list." })
vim.keymap.set('n', '<leader>ls', ts_builtin.buffers,        { noremap = true, desc = "Show buffer list." })

vim.keymap.set('n', '<leader>pv', ":Telescope file_browser path=%:p:h<CR>", { noremap = true })

vim.keymap.set('n', '<leader>vb', ":Gitsigns blame_line<CR>", { noremap = true })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local opts = { buffer = ev.buf, remap = false }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", })
    vim.keymap.set('n', '<C-S>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', 'gtD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gtd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Special shorthand
    vim.keymap.set('n', 'gtt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gti', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gtr', ts_builtin.lsp_references, { noremap = true, desc = "Find references of symbol under cursor." })

    vim.keymap.set('n', '<leader>s',  ts_builtin.lsp_document_symbols, { noremap = true, desc = "Show document symbols."})
    vim.keymap.set('n', '<leader>S',  ts_builtin.lsp_workspace_symbols, { noremap = true, desc = "Show workspace symbols."})

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>vf', vim.lsp.buf.code_action, opts)

    vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {});

    if client ~= nil and client.name == 'clangd' then
      vim.keymap.set('n', '<C-h>', function() vim.cmd("ClangdSwitchSourceHeader") end)
    end
  end
})

-- ToggleTerm
vim.keymap.set({'n', 'i', 't', 'v'}, '<C-t>', function() vim.api.nvim_command('ToggleTerm') end)
vim.api.nvim_create_autocmd( { "TermOpen" }, {
  callback = function(args)
    local opts = { noremap = true, buffer = args.buf }
    -- vim.keymap.set('n', '<C-z>', '<CMD>TermSelect', opts)
    vim.keymap.set('t', '<C-d>', '<C-\\><C-n>', opts) -- Ctrl-d to exit terminal mode
    -- vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]], opts)
    -- vim.keymap.set('n', '<ESC>', function() vim.api.nvim_command("ToggleTerm") end, opts)
  end
})

vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)


-- Tree-sitter
vim.api.nvim_create_user_command("Context", function() vim.api.nvim_command("TSContextToggle") end, {})

-- Git
vim.api.nvim_create_user_command("Blame", function() vim.api.nvim_command("Gitsigns toggle_current_line_blame") end, {})

-- Unsets
vim.keymap.del('n', 'grn') -- Unbind default rename


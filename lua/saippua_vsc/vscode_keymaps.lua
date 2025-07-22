

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.ignorecase = true
vim.o.smartcase = true

-- yank, paste and cut to system clipboard
keymap({"n", "v"}, "y", '"+y', opts)
keymap({"n", "v"}, "p", '"+p', opts)
keymap({"n", "v"}, "x", '"+x', opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- -- move text up and down
-- keymap("v", "J", ":m .+1<CR>==", opts)
-- keymap("v", "K", ":m .-2<CR>==", opts)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- vim.keymap.set('n', '<leader>conf', ":tabnew ~/.config/nvim/<CR>", { noremap = true })

-- keymap({"n", "v"}, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
-- keymap({"n", "v"}, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
-- keymap({"n", "v"}, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
-- keymap({"n", "v"}, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
-- keymap({"n", "v"}, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap("n", "K",         "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap("n", "gra", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap("n", "grr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>")
keymap("n", "grn", "<cmd>lua require('vscode').action('editor.action.rename')<CR>")
keymap("n", "grd", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>")
keymap("n", "gd", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>")
keymap("n", "grI", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>")
keymap("n", "grs", "<cmd>lua require('vscode').action('editor.action.goToSymbol')<CR>")
keymap("n", "grS", "<cmd>lua require('vscode').action('editor.action.goToSymbol')<CR>") -- change to workspace symbol
keymap("n", "grD", "<cmd>lua require('vscode').action('editor.action.revealDeclaration')<CR>")

keymap("n", "<leader>dn", "<cmd>lua require('vscode').action('editor.action.marker.nextInFiles')<CR>")
keymap("n", "<leader>dp", "<cmd>lua require('vscode').action('editor.action.marker.prevInFiles')<CR>")
keymap("n", "<leader>dl", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap("n", "<leader>vd", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap("n", "<C-S>", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")


keymap({"n", "v"}, "<leader>va", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap({"n", "v"}, "<leader>pf", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({"n", "v"}, "<leader>ps", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>")
keymap({"n" }, "<leader>pa", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap({"n" }, "<leader>pe", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
keymap({"n" }, "<leader>pq", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")

keymap({"n" }, "<C-w><C-k>", "<cmd>lua require('vscode').action('workbench.action.terminal.resizePaneUp')<CR>")
keymap({"n" }, "<C-w><C-j>", "<cmd>lua require('vscode').action('workbench.action.terminal.resizePaneDown')<CR>")

keymap({"n" }, "<leader>h", "<cmd>lua require('vscode').action('C_Cpp.SwitchHeaderSource')<CR>")

vim.api.nvim_create_user_command('Format', function() require('vscode').action('editor.action.formatDocument') end, {})

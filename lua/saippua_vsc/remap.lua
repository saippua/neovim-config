
-- Custom escape sequences
vim.cmd [[ 
set <F15>=[1;6I
set <F16>=[1;6I
set <F17>=[1;7I

nmap <F15> <C-Tab>
nmap <F16> <C-S-Tab>
nmap <F17> <C-BS>

imap <F15> <C-Tab>
imap <F16> <C-S-Tab>
imap <F17> <C-BS>

nmap <C-Tab> :echo 'test'<CR>
nmap <F15> :echo 'test2'<CR>

]]


-- vim.keymap.set( "i", "<F15>", "<C-Tab>",    { noremap = false })
-- vim.keymap.set( "i", "<F16>", "<C-S-Tab>",  { noremap = false })
-- vim.keymap.set( "i", "<F17>", "<C-BS>",     { noremap = false })
-- vim.keymap.set( "n", "<F15>", "<C-Tab>",    { noremap = false })
-- vim.keymap.set( "n", "<F17>", "<C-BS>",     { noremap = false })

-- vim.keymap.set( "n", "<F12>", ":echo 'test2'", {noremap = false })
-- vim.keymap.set( "n", "<F15>", ":echo 'test'", { noremap = false })
-- Config shortcut

-- Navigation
-- Splits
-- vim.keymap.set( "n", "<C-h>", "<C-w>h", { noremap = true })
-- vim.keymap.set( "n", "<C-j>", "<C-w>j", { noremap = true })
-- vim.keymap.set( "n", "<C-k>", "<C-w>k", { noremap = true })
-- vim.keymap.set( "n", "<C-l>", "<C-w>l", { noremap = true })
-- Tabs
vim.keymap.set( "n", "<C-w><C-h>", "gT", { noremap = true })
vim.keymap.set( "n", "<C-w><C-l>", "gt", { noremap = true })

-- Redirect delete and change to null register to avoid overwriting clipboard
vim.keymap.set( "n", "d", "\"_d", { noremap = true })
vim.keymap.set( "v", "d", "\"_d", { noremap = true })
vim.keymap.set( "v", "c", "\"_c", { noremap = true })

vim.keymap.set( "n", "<C-j>", "4j", { noremap = true })
vim.keymap.set( "n", "<C-k>", "4k", { noremap = true })

vim.keymap.set( "t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.keymap.set( "i", "<C-j>", "<Down>",  { noremap = true })
vim.keymap.set( "i", "<C-k>", "<Up>",    { noremap = true })
vim.keymap.set( "i", "<C-h>", "<Left>",  { noremap = true })
vim.keymap.set( "i", "<C-l>", "<Right>", { noremap = true })


vim.wo.wrap = true
vim.wo.linebreak = true

vim.keymap.set("n", "j", "gj");
vim.keymap.set("n", "k", "gk");
vim.keymap.set("v", "j", "gj");
vim.keymap.set("v", "k", "gk");

vim.keymap.set("n", "<leader>b", ":e ./tex/references.bib<CR>");

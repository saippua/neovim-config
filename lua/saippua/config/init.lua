vim.opt.nu = true
vim.opt.rnu = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.mouse="a"
vim.opt.mousemodel="extend"

vim.opt.wrap = false

vim.opt.swapfile = true
vim.opt.updatetime = 200
vim.opt.backup = false
-- vim.opt.undodir = 
-- vim.opt.undofile = true


vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.signcolumn = 'yes'

vim.opt.termguicolors = true
vim.opt.scrolloff = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true


vim.filetype.add({
  extension = {
    ets = 'typescript'
  }
})

if is_win then
  -- vim.opt.shell='powershell' -- default (5.x)
  vim.opt.shell='pwsh' -- 7.x
end

-- require('saippua.config.terminal')
require('saippua.config.keymaps')

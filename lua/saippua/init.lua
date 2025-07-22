
vim.g.mapleader = " "
vim.o.fileformats = 'dos'

_G.is_win = vim.uv.os_uname().sysname:find 'Windows' and true or false
_G.is_linux = vim.uv.os_uname().sysname == 'Linux'
_G.is_wsl = is_linux and vim.uv.os_uname().release:find 'Microsoft' and true or false

if is_win then
  vim.keymap.set('n', '<leader>conf', ":tabnew ~/AppData/Local/nvim/<CR>", { noremap = true })
else
  vim.keymap.set('n', '<leader>conf', ":tabnew ~/.config/nvim/<CR>", { noremap = true })
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup('saippua.plugins', {
  change_detection = {
    notify = false,
  },
})

require('saippua.plugins')
require('saippua.config')



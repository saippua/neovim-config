return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = { },
  config = function()

    -- Patch for powershell in windows
    vim.cmd("let &shell = 'pwsh'")
    vim.cmd("let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'")
    vim.cmd("let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'")
    vim.cmd("let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'")
    vim.cmd("set shellquote= shellxquote=")

    require('toggleterm').setup {
      shade_terminals=true,
      shading_factor=-30,
      persist_mode = false,
      terminal_mappings = false,
    }

  end,
}


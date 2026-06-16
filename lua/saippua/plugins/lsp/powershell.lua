local M = {}

function M.setup()
  if not is_win then return end

  vim.lsp.config('powershell_es', {
    bundle_path = vim.fn.stdpath('config') .. "\\PowerShellEditorServices",
    init_options = {
      enableProfileLoading = false,
    },
  })
  vim.lsp.enable('powershell_es')
end

return M

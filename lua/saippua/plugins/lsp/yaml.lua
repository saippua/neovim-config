local M = {}

function M.setup()
  vim.lsp.config('yamlls', {
    settings = {
      yaml = {
        customTags = {
          "!reference sequence",
        }
      }
    }
  })
  vim.lsp.enable('yamlls')
end

return M

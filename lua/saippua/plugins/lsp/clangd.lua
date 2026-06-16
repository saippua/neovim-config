local M = {}

function M.setup()
  vim.lsp.config('clangd', {
    cmd = {
      "clangd",
      -- "--background-index",
      -- "--clang-tidy",
      -- "--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
      -- "--completion-parse=always",
      -- "--completion-style=bundled",
      -- "--debug-origin",
      -- "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
      -- "--folding-ranges",
      -- "--function-arg-placeholders",
      -- "--header-insertion=iwyu",
      -- "--pch-storage=memory", -- could also be disk
      -- "--suggest-missing-includes",
      "-j=4", -- number of workers
      -- "--resource-dir=",
      -- "--log=error",
      -- "--query-driver=D:\\Tools\\command-line-tools\\sdk\\default\\openharmony\\native\\llvm\\bin\\clang++.exe"
    },
  })
  vim.lsp.enable('clangd')
end

return M

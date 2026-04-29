return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'hrsh7th/nvim-cmp' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    if is_win then
      vim.lsp.config('powershell_es', {
        bundle_path = vim.fn.stdpath('config') .. "\\PowerShellEditorServices",
        init_options = {
          enableProfileLoading = false,
        },
      })
      vim.lsp.enable('powershell_es')
    end

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

    local jenkins_classpath = { "/home/huawei/jenkins_libs/core/*" }
    for _, dir in ipairs(vim.fn.glob("/home/huawei/jenkins_libs/plugins/*/WEB-INF/lib", true, true)) do
      table.insert(jenkins_classpath, dir .. "/*")
    end

    vim.lsp.config('groovyls', {
      cmd = { 'groovy-language-server' },
      settings = {
        groovy = {
          classpath = jenkins_classpath,
        }
      }
    })
    vim.lsp.enable('groovyls')

    vim.lsp.enable('neocmake')

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
}

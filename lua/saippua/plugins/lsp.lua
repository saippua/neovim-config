return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'hrsh7th/nvim-cmp' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    if is_win then
      require('lspconfig').powershell_es.setup {
        bundle_path = vim.fn.stdpath('config') .. "\\PowerShellEditorServices",
        init_options = {
          enableProfileLoading = false,
        },
      }
    end

    require('mason-lspconfig').setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {}
      end,
    }

    require('lspconfig').yamlls.setup {
      settings = {
        yaml = {
          customTags = {
            "!reference sequence",
          }
        }
      }
    }

    require('lspconfig').neocmake.setup {}

    require('lspconfig').clangd.setup {
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
    }
  end
}

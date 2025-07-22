return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context'
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = { "cpp", "lua", "python" },

        sync_install = false,

        auto_install = false,
        ignore_install = {},
        modules = {},

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(_, buf)
              local max_filesize = 1000 * 1024 -- 1000 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            -- Keybindings are defined in the keybindings module
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = false,
            node_decremental = "<S-CR>",
          },
        },
      }
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.fsharp = {
        install_info = {
          url = "https://github.com/Nsidorenco/tree-sitter-fsharp",
          branch = "develop",
          files = { "src/scanner.cc", "src/parser.c" },
          generate_requires_npm = true,
          requires_generate_from_grammar = true
        },
        filetype = "fsharp",
      }
      parser_config.powershell = {
        install_info = {
          url = "https://github.com/airbus-cert/tree-sitter-powershell",
          branch = "main",
          files = { "src/parser.c", "src/scanner.c" },
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "ps1",
      }

      require'treesitter-context'.setup {
        enable = true
      }

    end
  },
  {
    'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  }
}

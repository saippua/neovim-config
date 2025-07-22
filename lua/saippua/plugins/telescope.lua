return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        version = "^1.0.0",
      },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            }
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {
            }
          },
        },
      }

      require('telescope').load_extension("live_grep_args")
      require('telescope').load_extension("ui-select")
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      local fb_actions = require "telescope._extensions.file_browser.actions"
      require('telescope').setup {
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            depth=1,
            auto_depth=false,
            hide_parent_dir=false,
            prompt_path=false,
            -- initial_mode = "normal",

            mappings= {
              ["i"] = {
                ["<M-c>"] = false, -- unmap create
              },
              ["n"] = {
                ["g"] = false,
                ["<BS>"] = fb_actions.backspace,
                ["c"] = false,
                ["%"] = fb_actions.create,
              }
            }
          }
        },
        file_ignore_patterns = { "node_modules", "**/.git/*" }
      }
      require('telescope').load_extension 'file_browser'
    end,
  },
}

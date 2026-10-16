return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup({
      keymaps = {
        window_navigation = false, -- Don't map <C-h/j/k/l>, we use <C-w>+hjkl below
        scrolling = false,         -- Its <C-f/b> maps re-enter terminal mode, which undoes the scroll
      },
    })

    -- <C-w>+hjkl to leave the Claude terminal, like any other window
    vim.api.nvim_create_autocmd("TermOpen", {
      callback = function(args)
        -- The buffer is renamed right after :terminal, so check on the next tick
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(args.buf) then return end
          local name = vim.api.nvim_buf_get_name(args.buf)
          if not vim.fn.fnamemodify(name, ':t'):match('^claude%-code') then return end

          for _, dir in ipairs({ 'h', 'j', 'k', 'l' }) do
            vim.keymap.set('t', '<C-w>' .. dir, [[<C-\><C-n><C-w>]] .. dir, {
              buffer = args.buf,
              noremap = true,
              silent = true,
              desc = 'Window: move ' .. dir,
            })
          end

          -- <C-z> would otherwise go straight to the pty, where the tty driver
          -- turns it into SIGTSTP for Claude -- a stopped process behind a
          -- buffer that still looks alive. Suspend nvim instead, which is what
          -- <C-z> does everywhere else; `fg` in the shell brings it all back.
          vim.keymap.set('t', '<C-z>', function()
            -- VimResume fires when the shell foregrounds us again; hop back
            -- into the terminal so the session picks up where it left off.
            vim.api.nvim_create_autocmd('VimResume', {
              once = true,
              callback = function()
                vim.schedule(function()
                  if vim.api.nvim_get_current_buf() == args.buf then
                    vim.cmd('startinsert')
                  end
                end)
              end,
              desc = 'Claude: back to terminal mode after fg',
            })
            vim.cmd('stopinsert')
            vim.cmd('suspend')
          end, {
            buffer = args.buf,
            silent = true,
            desc = 'Suspend nvim (not Claude)',
          })

          -- Claude runs on the alternate screen (it emits ESC[?1049h), so this
          -- buffer only ever holds the visible screen -- there is no scrollback
          -- for nvim to scroll, whatever 'scrollback' says. Scrolling is
          -- Claude's own job, which is why there are no <C-f>/<C-b> maps here.
          --
          -- In normal mode these keys would go to nvim and do nothing, so hand
          -- them to Claude instead. The sequences are exactly what nvim itself
          -- sends for these keys in terminal mode (Claude leaves DECCKM off).
          local function send(seq)
            local job = vim.b[args.buf].terminal_job_id
            if job then vim.fn.chansend(job, seq) end
          end

          -- j/k scroll a notch at a time. Claude has no key for that, but it
          -- does ask for SGR mouse reporting (ESC[?1006h), so send it the wheel
          -- events it already scrolls on. 64 = wheel up, 65 = wheel down;
          -- the coordinates just have to land inside the window.
          local function wheel(button, count)
            local row = math.max(1, math.floor(vim.fn.winheight(0) / 2))
            local col = math.max(1, math.floor(vim.fn.winwidth(0) / 2))
            send(string.rep(string.format('\27[<%d;%d;%dM', button, col, row), count))
          end

          -- j/k/<C-u>/<C-d> move the cursor as usual, but the buffer is only one
          -- screen tall, so nvim runs out of lines at the edge. There the cursor
          -- stops at 'scrolloff' and the distance it could not travel is handed
          -- to Claude as that many wheel notches (one notch = one line), which
          -- is what brings older output in. Net effect: the view moves by the
          -- full motion distance while the cursor stays put, same as scrolling
          -- through a long file.
          local function motion(page, up)
            return function()
              local so = vim.wo.scrolloff
              local last = vim.fn.line('$')
              local cur = vim.fn.line('.')

              local dist
              if vim.v.count > 0 then
                dist = vim.v.count
              elseif page then
                -- what <C-u>/<C-d> would move: 'scroll', i.e. half a window
                dist = vim.wo.scroll > 0 and vim.wo.scroll
                  or math.max(1, math.floor(vim.fn.winheight(0) / 2))
              else
                dist = 1
              end

              local target, limit
              if up then
                target = cur - dist
                limit = math.min(1 + so, last)
                if target < limit then
                  wheel(64, limit - target)
                  target = limit
                end
              else
                target = cur + dist
                limit = math.max(last - so, 1)
                if target > limit then
                  wheel(65, target - limit)
                  target = limit
                end
              end

              target = math.max(1, math.min(target, last))
              vim.api.nvim_win_set_cursor(0, { target, vim.fn.col('.') - 1 })
            end
          end

          local to_claude = {
            ['<PageUp>']   = function() send('\27[5~') end,
            ['<PageDown>'] = function() send('\27[6~') end,
            ['<Home>']     = function() send('\27[H') end,
            ['<End>']      = function() send('\27[F') end,
            ['k']          = motion(false, true),
            ['j']          = motion(false, false),
            ['<C-u>']      = motion(true, true),
            ['<C-d>']      = motion(true, false),
          }
          for lhs, fn in pairs(to_claude) do
            vim.keymap.set('n', lhs, fn, {
              buffer = args.buf,
              silent = true,
              desc = 'Claude: send ' .. lhs,
            })
          end
        end)
      end
    })
  end
}

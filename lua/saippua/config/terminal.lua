-- Exit terminal with Esc or Ctrl+C... which one is better?
-- vim.keymap.set("t", "<C-c>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set( "t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.keymap.set({"n", "v"}, "<C-z>", function()

  -- local tabs = vim.api.nvim_list_tabpages()
  -- for _, tab_id in ipairs(tabs) do
  --   print(tab_id)
  --   local tab_win = vim.api.nvim_tabpage_get_win(tab_id)
  --   local tab_buf = vim.api.nvim_win_get_buf(tab_win)
  --   local buftype = vim.bo[tab_buf].buftype
  --
  --   print("BufType: " .. buftype)
  --   if buftype == 'terminal' then
  --
  --     -- Switch to the terminal tab if we aren't already
  --     if vim.api.nvim_get_current_tabpage() ~= tab_id then
  --       vim.api.nvim_set_current_tabpage(tab_id)
  --       vim.cmd.startinsert()
  --     end
  --
  --     return
  --   end
  -- end

  -- Don't do anything if we're already in a terminal
  if vim.bo[vim.api.nvim_get_current_buf()].buftype == 'terminal' then
    print("RETURN 1")
    return
  end

  -- Find a terminal buffer, or create one if one doesn't exist
  local terminal_buffer = nil
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype == 'terminal' then
      terminal_buffer = bufnr
      break
    end
  end
  if terminal_buffer ~= nil then
    -- If an existing terminal tab was found, check if it exists in a tab
    -- Look through all windows in all tabs
    for _, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
      for _, winnr in ipairs(vim.api.nvim_tabpage_list_wins(tabnr)) do
        local win_buf = vim.api.nvim_win_get_buf(winnr)
        if vim.bo[win_buf].buftype == 'terminal' then
          vim.api.nvim_set_current_tabpage(tabnr)
          vim.api.nvim_tabpage_set_win(tabnr, winnr)
          vim.cmd.startinsert()
          print("RETURN 2")
          return -- Then we're done
        end
      end
    end
  else
    print("CREATE TERM BUFFER")
    -- Terminal buffer was not found. We'll create one
    terminal_buffer = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_open_term(terminal_buffer, {})
  end

  print("CREATE TERM TAB")
  -- Create a tab for the new terminal buffer
  vim.api.nvim_command("tab sb" .. terminal_buffer)
  vim.cmd.startinsert()
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  callback = function(_)
    vim.wo.number = false
  end
})

vim.api.nvim_create_autocmd({ "TermClose" }, {
  callback = function(_)
    vim.g.ok_term_buffer = nil
  end
})

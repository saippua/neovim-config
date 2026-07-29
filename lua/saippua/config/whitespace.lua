-- Highlight trailing whitespace in red, controlled with :Trailing on / :Trailing off

vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#ff0000" })

local pattern = [[\s\+$]]

local function clear_matches()
  for _, m in ipairs(vim.fn.getmatches()) do
    if m.group == "TrailingWhitespace" then
      vim.fn.matchdelete(m.id)
    end
  end
end

vim.api.nvim_create_user_command("Trailing", function(opts)
  local arg = opts.args
  if arg == "on" then
    clear_matches() -- avoid stacking duplicates
    vim.fn.matchadd("TrailingWhitespace", pattern)
  elseif arg == "off" then
    clear_matches()
  else
    vim.notify("Usage: :Trailing on | off", vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  complete = function()
    return { "on", "off" }
  end,
  desc = "Toggle trailing whitespace highlighting (on/off)",
})

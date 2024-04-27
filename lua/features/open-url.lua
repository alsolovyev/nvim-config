-- Opens a URL found on the current line in the default browser
return function()
  local current_line = vim.api.nvim_get_current_line()
  local url = current_line:match('(https?://[%w-_%.]+%.%w[%w-_%.%%%?%.:/+=&%%[%]#]*)')

  if url then
    vim.cmd('silent exec "!open \'' .. url .. '\'"')
  end
end

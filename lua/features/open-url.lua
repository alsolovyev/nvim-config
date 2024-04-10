local url_pattern = '(https?://[%w-_%.]+%.%w[%w-_%.%%%?%.:/+=&%%[%]#]*)'

return function()
  local current_line = vim.api.nvim_get_current_line()
  local url = current_line:match(url_pattern)

  if url then
    vim.cmd('silent exec "!open \'' .. url .. '\'"')
  end
end

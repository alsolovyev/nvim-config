-- Removes all whitespace and newline characters from the selected range, EXCEPT those inside double quotes.
vim.api.nvim_create_user_command('RemoveSpaces', function(opts)
  local range = opts.line1 .. ',' .. opts.line2
  vim.cmd(range .. 's/\\v(\\"[^\\"]*\\")|\\s|\\n/\\1/g')
end, { range = '%' })

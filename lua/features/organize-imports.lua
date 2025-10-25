--- Organize imports using LSP code action if available
--- @return boolean success Whether the operation was successful
return function()
  local bufnr = 0

  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if vim.tbl_isempty(clients) then
    return false
  end

  local ok, err = pcall(function()
    vim.lsp.buf.code_action({
      apply = true,
      bufnr = bufnr,
      context = { only = { 'source.organizeImports' } },
    })
  end)

  if not ok then
    vim.notify('Failed to organize imports: ' .. tostring(err), vim.log.levels.WARN)
  end

  return ok
end

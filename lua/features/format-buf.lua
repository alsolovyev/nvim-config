-- Formats the current buffer using either Prettier or LSP (Language Server Protocol) formatting,
-- depending on the filetype and available LSP clients.
--
-- If the buffer is not modified, not modifiable, or is in binary mode, it does nothing.
-- For specific filetypes listed, it formats using Prettier and notifies the user.
-- For other filetypes, it trims trailing whitespace and empty lines, then attempts to format using LSP.
--
-- Note: Ensure that Prettier and LSP servers are properly configured and available in your environment.
return function()
  if not vim.bo.modified or not vim.bo.modifiable or vim.bo.binary then
    return
  end

  for _, filetype in ipairs({
    'css', 'graphql', 'handlebars', 'html', 'javascript', 'javascriptreact', 'json',
    'jsonc', 'less', 'markdown', 'markdown.mdx', 'scss', 'typescript', 'typescriptreact',
    'vue', 'yaml'
  }) do
    if filetype == vim.bo.filetype then
      local view_state = vim.fn.winsaveview()

      vim.cmd [[silent %!prettier --find-config-path --stdin-filepath %]]
      vim.notify('Formatted using Prettier')

      vim.fn.winrestview(view_state)

      return
    end
  end

  local view_state = vim.fn.winsaveview()

  vim.cmd [[silent! %s#\($\n\s*\)\+\%$##]] -- Trim the end lines
  vim.cmd [[silent! %s/\s\+$//e]]          -- Trim trailing whitespaces

  vim.fn.winrestview(view_state)

  for _, client in pairs(vim.lsp.buf_get_clients()) do
    if client.supports_method('textDocument/formatting') then
      vim.lsp.buf.format { async = false }
      vim.notify('Formatted using LSP: ' .. client.name)
      return
    end
  end
end

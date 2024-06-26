-- Opens a float window for user input to rename all references to the symbol under the cursor
return function()
  local current_name = vim.fn.expand '<cword>'
  if current_name == '' then
    return vim.notify('Nothing to rename')
  end

  vim.lsp.buf.document_highlight()

  local bufnr = vim.api.nvim_create_buf(false, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = 'cursor',
    row = 1,
    col = 0,
    width = 30,
    height = 1,
    style = 'minimal',
    border = 'single',
    title = { { ' Rename ', 'CustomRenameTitle' } },
    title_pos = 'center',
  })

  vim.api.nvim_buf_set_lines(bufnr, 0, 1, true, { current_name })

  -- Create an autocmd to close the renaming window when leaving the buffer.
  local leave_autocmd_id = vim.api.nvim_create_autocmd('BufLeave', {
    desc = 'Close the rename window',
    group = vim.api.nvim_create_augroup('CloseRenameWindow', { clear = true }),
    buffer = bufnr,
    once = true,
    callback = function()
      vim.api.nvim_win_close(win_id, true)
      vim.lsp.buf.clear_references()
    end
  })

  -- Set key mappings for handling user input in the renaming window.
  vim.keymap.set({ 'i', 'n' }, '<CR>', function()
    local new_name = vim.trim(vim.api.nvim_get_current_line())

    vim.api.nvim_del_autocmd(leave_autocmd_id)
    vim.api.nvim_win_close(win_id, true)

    vim.cmd [[stopinsert]]
    vim.cmd [[normal! l]]

    if new_name and #new_name > 0 and not (new_name == current_name) then
      vim.lsp.buf.rename(new_name)
    end

    vim.lsp.buf.clear_references()
  end, { buffer = bufnr, silent = true })

  -- Set a key mapping to cancel the renaming operation.
  vim.keymap.set('n', '<Esc>', function()
    vim.api.nvim_win_close(win_id, true)
    vim.lsp.buf.clear_references()
  end, { buffer = bufnr, silent = true })
end

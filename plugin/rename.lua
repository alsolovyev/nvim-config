local function is_lsp_rename_supported(bufnr)
  for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.server_capabilities.renameProvider then
      return true
    end
  end

  return false
end

vim.api.nvim_create_user_command('Rename', function(_)
  local current_name = vim.fn.expand '<cword>'
  if current_name == '' then
    return vim.notify('Nothing to rename', vim.log.levels.WARN)
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  local win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = 'cursor',
    row = 1,
    col = 0,
    width = 30,
    height = 1,
    style = 'minimal',
    border = 'single',
    title = { { ' Rename ', 'NormalFloat' } },
    title_pos = 'center',
  })

  vim.api.nvim_buf_set_lines(bufnr, 0, 1, true, { current_name })

  -- Create an autocmd to close the renaming window when leaving the buffer.
  local leave_autocmd_id = vim.api.nvim_create_autocmd('BufLeave', {
    desc = 'Close the rename window',
    group = vim.api.nvim_create_augroup('CloseRenameWindow', { clear = true }),
    buffer = bufnr,
    callback = function()
      vim.api.nvim_win_close(win_id, true)
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  })

  -- Set key mappings for handling user input in the renaming window.
  vim.keymap.set({ 'i', 'n' }, '<CR>', function()
    local new_name = vim.trim(vim.api.nvim_get_current_line())

    vim.api.nvim_del_autocmd(leave_autocmd_id)
    vim.api.nvim_win_close(win_id, true)

    vim.cmd [[stopinsert]]
    vim.cmd [[normal! l]]

    if #new_name == 0 or new_name == current_name then
      return
    end

    if is_lsp_rename_supported(0) then
      return vim.lsp.buf.rename(new_name)
    end

    vim.cmd('%s/' .. current_name .. '/' .. new_name .. '/gc')
  end, { buffer = bufnr, silent = true })

  -- Set a key mapping to cancel the renaming operation.
  vim.keymap.set('n', '<Esc>', function()
    vim.api.nvim_win_close(win_id, true)
  end, { buffer = bufnr, silent = true })
end, {})

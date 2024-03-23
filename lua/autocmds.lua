-- https://neovim.io/doc/user/autocmd

-- Restore cursor shape on leave
vim.api.nvim_create_autocmd('VimLeave', {
  desc = 'Restore cursor shape on leave',
  group = vim.api.nvim_create_augroup('RestoreCursor', { clear = true }),
  command = [[set guicursor=a:hor25]],
})

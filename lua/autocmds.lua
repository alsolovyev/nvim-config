-- https://neovim.io/doc/user/autocmd

-- Restore cursor shape on leave
vim.api.nvim_create_autocmd('VimLeave', {
  desc = 'Restore cursor shape on leave',
  group = vim.api.nvim_create_augroup('RestoreCursor', { clear = true }),
  command = [[set guicursor=a:hor25]],
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end
})

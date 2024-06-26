-- https://neovim.io/doc/user/autocmd

-- Restore cursor shape on leave
vim.api.nvim_create_autocmd('VimLeave', {
  desc = 'Restore cursor shape on leave',
  group = vim.api.nvim_create_augroup('RestoreCursor', { clear = true }),
  command = [[set guicursor=a:hor25]],
})

-- Automatically organize imports before writing buffer contents for Go files
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Organize imports before saving buffer (Go files)',
  group = vim.api.nvim_create_augroup('OrganizeImports', { clear = true }),
  pattern = '*.go',
  callback = function()
    if vim.bo.modified then
      vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
    end
  end
})

-- Automatically trigger code formatting before writing buffer contents
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Automatically format code before saving buffer',
  group = vim.api.nvim_create_augroup('CodeFormatting', { clear = true }),
  callback = function()
    if not vim.bo.modified or not vim.bo.modifiable or vim.bo.binary then
      return
    end

    vim.lsp.buf.format()
  end
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end
})

-- User event that loads after UIEnter + only if file buf is there
vim.api.nvim_create_autocmd({ 'UIEnter', 'BufReadPost', 'BufNewFile' }, {
  desc = 'User event that loads after UIEnter + only if file buf is there',
  group = vim.api.nvim_create_augroup('NvFilePost', { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_buf_get_option(args.buf, 'buftype')

    if not vim.g.ui_entered and args.event == 'UIEnter' then
      vim.g.ui_entered = true
    end

    if file ~= '' and buftype ~= 'nofile' and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds('User', { pattern = 'FilePost', modeline = false })
      vim.api.nvim_del_augroup_by_name 'NvFilePost'

      vim.schedule(function()
        vim.api.nvim_exec_autocmds('FileType', {})

        if vim.g.editorconfig then
          require('editorconfig').config(args.buf)
        end
      end, 0)
    end
  end,
})

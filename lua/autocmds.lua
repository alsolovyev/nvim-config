-- https://neovim.io/doc/user/autocmd

-- Restore cursor shape on leave
vim.api.nvim_create_autocmd('VimLeave', {
  desc = 'Restore cursor shape on leave',
  group = vim.api.nvim_create_augroup('RestoreCursor', { clear = true }),
  command = [[set guicursor=a:hor25]],
})

-- Configures terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Disable line numbers in terminal windows',
  group = vim.api.nvim_create_augroup('TerminalSettings', { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Automatically trigger code formatting before writing buffer contents
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Automatically format code before saving buffer',
  group = vim.api.nvim_create_augroup('CodeFormatting', { clear = true }),
  callback = function(args)
    local buf = args.buf

    local is_modified = vim.bo[buf].modified
    local is_modifiable = vim.bo[buf].modifiable
    local is_binary = vim.bo[buf].binary

    if is_modified and is_modifiable and not is_binary then
      require('conform').format({ bufnr = buf })
    end
  end,
})

-- Automatically organize imports before writing buffer contents for Go files
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Organize imports before saving buffer (Go files)',
  group = vim.api.nvim_create_augroup('OrganizeImports', { clear = true }),
  pattern = '*.go',
  callback = require 'features.organize-imports',
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
})

-- User event that loads after UIEnter + only if file buf is there
vim.api.nvim_create_autocmd({ 'UIEnter', 'BufReadPost', 'BufNewFile' }, {
  desc = 'User event that loads after UIEnter + only if file buf is there',
  group = vim.api.nvim_create_augroup('NvFilePost', { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })

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
      end)
    end
  end,
})

-- https://github.com/saghen/blink.cmp
local M = { 'saghen/blink.cmp' }

M.event = 'InsertEnter'
M.version = '*'

M.opts = {
  completion = {
    menu = {
      border = 'rounded',
      draw = { columns = { { 'label' } } }
    },
    documentation = { window = { border = 'rounded' } },
  },
  keymap = {
    preset        = 'none',
    ['<C-CR>']    = { 'accept', 'fallback' },
    ['<C-j>']     = { 'select_next', 'fallback' },
    ['<C-k>']     = { 'select_prev', 'fallback' },
    ['<C-l>']     = { 'accept', 'fallback' }, -- for tmux
    ['<C-b>']     = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>']     = { 'scroll_documentation_down', 'fallback' },
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  },
  sources = {
    default = { 'lsp', 'path', 'buffer' },
  },
  signature = {
    enabled = true,
    window = { border = 'rounded' },
  }
}

return M

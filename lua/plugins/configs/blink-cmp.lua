-- https://github.com/saghen/blink.cmp
local M = { 'saghen/blink.cmp' }

M.event = 'InsertEnter'
M.version = '*'

M.opts = {
  completion = {
    menu = {
      draw = {
        columns = { { 'label', 'label_description', gap = 1 } },
        components = {
          label = {
            width = { fill = true, max = 20 },
          },
          label_description = {
            width = { max = 24 },
            text = function(ctx)
              local description = ctx.label_description
              if description == '' then
                description = ctx.item.detail or ('[' .. ctx.kind .. ']')
              end
              return description:gsub('\n', ' ')
            end,
          },
        },
      },
    },
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
  }
}

return M

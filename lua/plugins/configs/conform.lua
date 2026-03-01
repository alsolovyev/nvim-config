-- https://github.com/stevearc/conform.nvim
local M = { 'stevearc/conform.nvim' }

M.event = 'BufWritePre'

M.opts = {
  formatters_by_ft = {
    javascript      = { 'oxfmt' },
    javascriptreact = { 'oxfmt' },
    typescript      = { 'oxfmt' },
    typescriptreact = { 'oxfmt' },
    json            = { 'oxfmt' },
    vue             = { 'oxfmt' },

    lua = { 'stylua' },

    go = { 'gopls' },

    python = { 'ruff_fix', 'ruff_format' },
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },
}

return M

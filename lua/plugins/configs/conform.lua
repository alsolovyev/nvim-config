-- https://github.com/stevearc/conform.nvim
local M = { 'stevearc/conform.nvim' }

M.event = 'BufWritePre'

M.opts = {
  formatters_by_ft = {
    javascript      = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescript      = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },

    lua = { 'stylua' },

    go = { 'popls' },

    python = { 'ruff_fix', 'ruff_format' },
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },
}

return M

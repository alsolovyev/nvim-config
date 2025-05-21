-- https://github.com/stevearc/conform.nvim
local M = { 'stevearc/conform.nvim' }

M.module = 'conform'
M.opts = {
  formatters_by_ft = {
    python = { 'ruff_fix', 'ruff_format' }
  }
}

return M

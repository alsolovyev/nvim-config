-- https://github.com/nvim-treesitter/nvim-treesitter-context
local M = { 'nvim-treesitter/nvim-treesitter-context' }

M.event = 'WinScrolled'
M.dependencies = { 'nvim-treesitter/nvim-treesitter' }
M.opts = {
  max_lines = 1
}

return M

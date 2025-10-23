-- https://github.com/nvim-treesitter/nvim-treesitter-context
local M = { 'nvim-treesitter/nvim-treesitter-context' }

M.event = 'User Filepost' 
M.dependencies = { 'nvim-treesitter/nvim-treesitter' }
M.opts = {
  max_lines = 1
}

return M

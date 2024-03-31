-- https://github.com/nvim-telescope/telescope.nvim
local M = { 'nvim-telescope/telescope.nvim' }

M.cmd = 'Telescope'
M.dependencies = { 'nvim-lua/plenary.nvim' }

M.opts = {
  pickers = {
    find_files = {
      disable_devicons = true
    },
  },
  defaults = {
    -- entry_prefix = '',
    file_ignore_patterns = { 'node_modules' },
    prompt_prefix = '',
    selection_caret = '➜ '
  }
}

return M

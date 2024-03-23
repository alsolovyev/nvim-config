-- https://github.com/folke/which-key.nvim
local M = { 'folke/which-key.nvim' }

M.cmd = 'WhichKey'

-- https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
M.opts = {
  plugins = {
    marks = false,
    presets = {
      motions = false,
    }
  },
  window = {
    border = 'rounded',
    margin =  { 0, 0, 0, 0 },
    padding = { 1, 1, 1, 1 },
  },
}

return M

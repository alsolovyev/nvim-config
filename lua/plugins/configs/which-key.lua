-- https://github.com/folke/which-key.nvim
local M = { 'folke/which-key.nvim' }

M.cmd = 'WhichKey'

-- https://github.com/folke/which-key.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
M.opts = {
  delay = 800,
  spelling = {
    enabled = false
  },
  plugins = {
    marks = false,
    presets = {
      motions = false,
    }
  },
  win = {
    border = 'rounded',
    padding = { 1, 1, 1, 1 },
  }
}

return M

-- https://github.com/williamboman/mason.nvim
local M = { 'williamboman/mason.nvim' }

M.cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonInstallAll' }
M.config = {
  ui = {
    border = 'rounded'
  }
}

return M


-- https://github.com/nvimtools/none-ls.nvim 
local M = { 'nvimtools/none-ls.nvim' }

M.event = 'User FilePost'
M.dependencies = { 'nvim-lua/plenary.nvim' }
M.config = function()
  local null_ls = require('null-ls')

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettier
    }
  })
end

return M


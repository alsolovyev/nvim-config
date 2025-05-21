-- https://github.com/neovim/nvim-lspconfig
local M = { 'neovim/nvim-lspconfig' }

M.event = 'User FilePost'

M.config = function()
  vim.diagnostic.config({
    -- update_in_insert = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = false,
      header = '',
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅙',
        [vim.diagnostic.severity.HINT] = '󰌵',
        [vim.diagnostic.severity.INFO] = '󰋼',
        [vim.diagnostic.severity.WARN] = '',
      }
    }
  })
end

return M

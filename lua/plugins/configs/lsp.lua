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

  -- Common configuration
  vim.lsp.config('*', {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    root_markers = { '.git' },
    flags = {
      debounce_text_changes = 500
    }
  })
end

return M

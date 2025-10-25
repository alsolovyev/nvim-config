-- https://github.com/neovim/nvim-lspconfig
local M = { 'neovim/nvim-lspconfig' }

M.event = { 'BufReadPre', 'BufNewFile' }

M.config = function()
  vim.diagnostic.config({
    -- update_in_insert = true,
    float = {
      focusable = false,
      style = 'minimal',
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

  -- Lua configuration
  vim.lsp.config('lua_ls', { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })
  vim.lsp.enable('lua_ls')

  -- Python configuration
  vim.lsp.enable('ruff')
  vim.lsp.enable('pyright')

  vim.lsp.enable('gopls')
end

return M

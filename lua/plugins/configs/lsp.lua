-- https://github.com/neovim/nvim-lspconfig
local M = { 'neovim/nvim-lspconfig' }

M.event = { 'BufReadPre', 'BufNewFile' }

M.config = function()
  vim.diagnostic.config({
    -- update_in_insert = true,
    float = {
      focusable = true,
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
      },
    },
  })

  -- Common
  vim.lsp.config('*', {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    root_markers = { '.git' },
    flags = {
      debounce_text_changes = 500,
    },
  })

  -- Lua
  vim.lsp.config('lua_ls', { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })
  vim.lsp.enable('lua_ls')

  -- Python
  vim.lsp.enable('ruff')
  vim.lsp.enable('pyright')

  -- Golang
  vim.lsp.enable('gopls')

  -- Deno
  vim.lsp.enable('denols')
  vim.lsp.config('denols', {
    root_markers = { "deno.json" },
    single_file_support = false,
  })

  -- TypeScript
  vim.lsp.enable('ts_ls')
  vim.lsp.config('ts_ls', {
    root_markers = { "package.json" },
    single_file_support = false,
  })
end

return M

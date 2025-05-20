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
  })

  -- Server configurations
  local lspconfig = require('lspconfig')

  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
            [vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy'] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })

  lspconfig.gopls.setup {}
  lspconfig.ruff.setup {}
  lspconfig.ts_ls.setup {}
end

return M

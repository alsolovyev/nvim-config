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
    -- root_markers = { '.git' },
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

  -- Vue
  vim.lsp.config('vtsls', {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = '@vue/typescript-plugin',
              location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
              languages = { 'vue' },
              configNamespace = 'typescript',
            },
          },
        },
      },
    },
    filetypes = { 'vue' }
  })
  vim.lsp.enable("vtsls")

  vim.lsp.config('vue_ls', {
    settings = {
      init_options = {
        typescript = {
          tsdk = '',
        },
      },
    },
  })
  vim.lsp.enable("vue_ls")

  if require("lspconfig").util.root_pattern("deno.json")(0) then
    -- Deno
    vim.lsp.enable('denols')
  else
    -- TypeScript
    vim.lsp.enable('ts_ls')
  end
end

return M

-- https://github.com/hrsh7th/nvim-cmp
local M = { 'hrsh7th/nvim-cmp' }

M.event = 'InsertEnter'
M.dependencies = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path' }

M.config = function()
  local cmp = require 'cmp'

  cmp.setup({
    completion = {
      completeopt = 'menu,menuone,preview,noselect'
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'    ] = cmp.mapping.scroll_docs(-4),
      ['<C-e>'    ] = cmp.mapping.abort(),
      ['<C-f>'    ] = cmp.mapping.scroll_docs(4),
      ['<C-j>'    ] = cmp.mapping.select_next_item(),
      ['<C-k>'    ] = cmp.mapping.select_prev_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-CR>'     ] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'buffer'   },
      { name = 'path'     },
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  })

  cmp.setup.filetype({ 'lua' }, {
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }),
  })
end

return M

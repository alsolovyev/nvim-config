-- https://github.com/nvim-treesitter/nvim-treesitter
local M = { 'nvim-treesitter/nvim-treesitter' }

-- The current main branch does not support lazy-loading.
M.lazy = false
M.build = ':TSUpdate'

M.config = function(_, opts)
  require('nvim-treesitter').setup(opts or {})

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      -- Start highlighting only when a parser is installed for this filetype.
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang and pcall(vim.treesitter.start, args.buf, lang) then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M

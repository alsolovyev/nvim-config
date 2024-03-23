-- https://github.com/catppuccin/nvim
local M = { 'catppuccin/nvim' }

M.name = 'catppuccin'
M.lazy = false
M.priority = 1000

M.init = function()
  vim.cmd.colorscheme 'catppuccin'
end

-- https://github.com/catppuccin/nvim#configuration
M.opts = {
  transparent_background = true,
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  integrations = {
    mason = true
  }
}

return M

-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim' -- ~/.local/share/nvim/lazy/lazy.nvim

if not vim.loop.fs_stat(lazypath) then
  print('Lazy.nvim is not installed')

  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
  require 'plugins.configs.catppuccin',
  require 'plugins.configs.treesitter',
  require 'plugins.configs.treesitter-context',
  require 'plugins.configs.nvim-tree',
  require 'plugins.configs.autopairs',
  require 'plugins.configs.gitsigns',
  require 'plugins.configs.comment',
  require 'plugins.configs.which-key',
}, require 'plugins.configs.lazy')

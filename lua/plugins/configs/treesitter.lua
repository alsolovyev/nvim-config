-- https://github.com/nvim-treesitter/nvim-treesitter
local M = { 'nvim-treesitter/nvim-treesitter' }

-- M.event = 'User FilePost'
M.build = ':TSUpdate'
M.cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' }
M.event = { 'BufReadPost', 'BufNewFile' }

M.opts = {
  auto_install = false,

  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true
  }
}

M.config = function(_, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return M
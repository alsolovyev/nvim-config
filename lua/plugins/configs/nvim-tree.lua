-- https://github.com/nvim-tree/nvim-tree.lua
local M = { 'nvim-tree/nvim-tree.lua' }

M.cmd = { 'NvimTreeToggle', 'NvimTreeFocus' }
M.dependencies = { 'nvim-tree/nvim-web-devicons' }
M.opts = {
  -- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
  disable_netrw = true,
  filesystem_watchers = {
    enable = false
  },
  view = {
    width = 20,
  },
  renderer = {
    special_files = {},
    highlight_git = true,
    icons = {
      show = {
        bookmarks = false,
        diagnostics = false,
        file = false,
        folder_arrow = false,
      },
      git_placement = 'signcolumn',
      glyphs = {
        git = {
          deleted = "",
          ignored = "◌",
          renamed = "➜",
          staged = "",
          unmerged = "",
          unstaged = "",
          untracked = "★",
        },
      },
    },
  },
}

return M

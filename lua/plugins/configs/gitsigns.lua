-- https://github.com/lewis6991/gitsigns.nvim
local M = { 'lewis6991/gitsigns.nvim' }

M.event = 'User FilePost'
M.cond = vim.fn.isdirectory '.git' ~= 0

M.opts = {
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    changedelete = { text = "▎" },
    delete       = { text = "" },
    topdelete    = { text = "" },
    untracked    = { text = "▎" },
  },
  preview_config = {
    border = 'rounded'
  }
}

return M

-- https://neovim.io/doc/user/api#nvim_set_hl()
local ok, catppuccin = pcall(require, 'catppuccin')

if not ok then
  print('The Catppuccin theme is not installed')
  return
end

local colors = require('catppuccin.palettes').get_palette 'mocha'
local transparent = catppuccin.options.transparent_background and 'NONE' or colors.mantle

-- Available color names (https://catppuccin.ryanccn.dev/palette):
--     base, blue, crust, flamingo, green, lavender, mantle, maroon, mauve,
--     overlay0, overlay1, overlay2, peach, pink, red, rosewater, sapphire,
--     sky, subtext0, subtext1, surface0, surface1, surface2, teal, text, yellow

-- Common
-- vim.api.nvim_set_hl(0, 'ExtraWhitespace', { fg = colors.red })
-- vim.api.nvim_set_hl(0, 'MsgArea',         { fg = colors.red })
-- vim.api.nvim_set_hl(0, 'NewlineChar',     { fg = colors.red })

-- Float window
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = colors.mantle })

-- nvim-tree
-- vim.api.nvim_set_hl(0, 'NvimTreeNormal',       {                   bg = colors.mantle            })
vim.api.nvim_set_hl(0, 'NvimTreeRootFolder',   { fg = colors.base, bg = colors.blue, bold = true })
vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { fg = colors.base                                })

-- Which-key
vim.api.nvim_set_hl(0, 'WhichKey',          { fg = colors.blue     })
vim.api.nvim_set_hl(0, 'WhichKeyDesc',      { fg = colors.red      })
vim.api.nvim_set_hl(0, 'WhichKeyGroup',     { fg = colors.green    })
vim.api.nvim_set_hl(0, 'WhichKeySeparator', { fg = colors.surface2 })
vim.api.nvim_set_hl(0, 'WhichKeyValue',     { fg = colors.green    })

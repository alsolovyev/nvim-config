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
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = colors.mantle, fg = colors.blue })

-- Rename
vim.api.nvim_set_hl(0, 'CustomRenameTitle', { bg = colors.mantle })

-- telescropt
vim.api.nvim_set_hl(0, 'TelescopeSelection',      { fg = colors.green                              })
vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', {                    link = 'TelescopeSelection' })

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

-- Statusline
-- vim.api.nvim_set_hl(0, 'Statusline',               { fg = colors.blue,  bg = colors.crust })
vim.api.nvim_set_hl(0, 'StatuslineFileName',       { fg = colors.overlay0                 })
vim.api.nvim_set_hl(0, 'StatuslineLspError',       { fg = colors.red                      })
vim.api.nvim_set_hl(0, 'StatuslineLspHints',       { fg = colors.green                    })
vim.api.nvim_set_hl(0, 'StatuslineLspInfo',        { fg = colors.blue                     })
vim.api.nvim_set_hl(0, 'StatuslineLspStatus',      { fg = colors.blue                     })
vim.api.nvim_set_hl(0, 'StatuslineLspWarning',     { fg = colors.peach                    })
vim.api.nvim_set_hl(0, 'StatuslineInsertMode',     { fg = colors.base,  bg = colors.mauve })
vim.api.nvim_set_hl(0, 'StatuslineInsertModeSep',  { fg = colors.mauve, bg = colors.base  })
vim.api.nvim_set_hl(0, 'StatuslineNormalMode',     { fg = colors.base,  bg = colors.blue  })
vim.api.nvim_set_hl(0, 'StatuslineNormalModeSep',  { fg = colors.blue                     })
vim.api.nvim_set_hl(0, 'StatuslineVisualMode',     { fg = colors.base,  bg = colors.teal  })
vim.api.nvim_set_hl(0, 'StatuslineVisualModeSep',  { fg = colors.teal,  bg = colors.base  })
vim.api.nvim_set_hl(0, 'StatuslineCommandMode',    { fg = colors.base,  bg = colors.red   })
vim.api.nvim_set_hl(0, 'StatuslineCommandModeSep', { fg = colors.red,   bg = colors.base  })
vim.api.nvim_set_hl(0, 'StatuslineReplaceMode',    { fg = colors.base,  bg = colors.red   })
vim.api.nvim_set_hl(0, 'StatuslineReplaceModeSep', { fg = colors.red,   bg = colors.base  })

-- TreesitterContext
vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = false })

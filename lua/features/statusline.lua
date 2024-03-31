-- File name
local file_name = '%#StatuslineFileName#%f %m'


-- LSP diagnostics
local diagnostics_cached = ''

-- https://neovim.io/doc/user/diagnostic.html#DiagnosticChanged
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  desc = 'Update diagnostics cache for the status line',
  group = vim.api.nvim_create_augroup('StatuslineDiagnostics', { clear = true }),
  callback = function(args)
    local diagnostics = { 0, 0, 0, 0 } -- error, warnings, info, hint

    for _, diagnostic in ipairs(args.data.diagnostics) do
      diagnostics[diagnostic.severity] = diagnostics[diagnostic.severity] + 1
    end

    local result = ''

    if diagnostics[1] > 0 then
      result = result .. '%#StatuslineLspError# ' .. diagnostics[1] .. ' '
    end

    if diagnostics[2] > 0 then
      result = result .. '%#StatuslineLspWarning# ' .. diagnostics[2] .. ' '
    end

    if diagnostics[3] > 0 then
      result = result .. '%#STAtuslineLspHints#󰛩 ' .. diagnostics[3] .. ' '
    end

    if diagnostics[4] > 0 then
      result = result .. '%#StatuslineLspInfo#󰋼 ' .. diagnostics[3] .. ' '
    end

    diagnostics_cached = result
  end,
})


-- Cursor location
-- local function location()
--   local line = vim.fn.line('.')
--   local col = vim.fn.virtcol('.')

--   return string.format('%3d:%-2d', line, col)
-- end


-- Nvim modes
--
-- Separators:
--  - round: left: , right: 
--  - squer left: █, right: █
--
local modes = {
  [''] = { 'V-BLOCK ', 'StatuslineVisualMode'  },
  ['c']  = { 'COMMAND ', 'StatuslineCommandMode' },
  ['i']  = { 'INSERT ',  'StatuslineInsertMode'  },
  ['n']  = { 'NORMAL ',  'StatuslineNormalMode'  },
  ['R']  = { 'REPLACE ', 'StatuslineReplaceMode' },
  ['V']  = { 'V-LINE ',  'StatuslineVisualMode'  },
  ['v']  = { 'VISUAL ',  'StatuslineVisualMode'  },
}

local function mode()
  local mode_code = vim.api.nvim_get_mode().mode
  if modes[mode_code] == nil then
    return mode_code
  end

  -- Right
  return '%#' .. modes[mode_code][2] .. 'Sep#%#' .. modes[mode_code][2] .. '# ' .. modes[mode_code][1]

  -- Left
  -- return '%#' .. modes[ mode_code][2].. '#  '.. modes[mode_code][1].. '%#'.. modes[mode_code][2].. 'Sep#'
end


return function()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)

  local sections = {
    -- Left
    file_name,
    '%##',

    -- Center
    '%=          ',
    diagnostics_cached,
    '%=',

    -- Right
    mode(),
  }

  return table.concat(sections)
end

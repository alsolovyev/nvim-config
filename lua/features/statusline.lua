-- File name
-- https://neovim.io/doc/user/options.html#'statusline'
local file_name = '%#StatuslineFileName#%f %M'


-- LSP diagnostics
local diagnostics_cached = ''

-- https://neovim.io/doc/user/diagnostic.html#DiagnosticChanged
vim.api.nvim_create_autocmd({ 'BufEnter', 'DiagnosticChanged' }, {
  desc = 'Update diagnostics for the status line',
  group = vim.api.nvim_create_augroup('StatuslineDiagnostics', { clear = true }),
  callback = function(args)
    local diagnostics = args.data and args.data.diagnostics or vim.diagnostic.get(args.buf)
    if next(diagnostics) == nil then
      diagnostics_cached = ''
      return
    end

    local diagnostics_counts = { 0, 0, 0, 0 } -- error, warnings, info, hint
    for _, diagnostic in ipairs(diagnostics) do
      diagnostics_counts[diagnostic.severity] = diagnostics_counts[diagnostic.severity] + 1
    end

    local result = ''
    local highlight_groups = {
      '%#StatuslineLspError# ',
      '%#StatuslineLspWarning# ',
      '%#STAtuslineLspHints#󰛩 ',
      '%#StatuslineLspInfo#󰋼 ',
    }

    for i, count in ipairs(diagnostics_counts) do
      if count > 0 then
        result = result .. highlight_groups[i] .. count .. ' '
      end
    end

    diagnostics_cached = result
  end,
})


-- Cursor location
local function location()
  local line = vim.fn.line('.')
  local col = vim.fn.virtcol('.')

  return string.format("%%#StatuslineLocation#%1d:%-1d%%* ", line, col)
end

-- Filetype / Syntax Name
local function file_syntax()
  local ft = vim.bo.filetype

  return string.format("%%#StatuslineLocation#%s%%* ", ft ~= "" and ft or "noft")
end


-- Nvim modes
--
-- Separators:
--  - round: left: , right: 
--  - squer left: █, right: █
--
local modes = {
  [''] = { 'V-BLOCK ', 'StatuslineVisualMode' },
  ['c'] = { 'COMMAND ', 'StatuslineCommandMode' },
  ['i'] = { 'INSERT ', 'StatuslineInsertMode' },
  ['n'] = { 'NORMAL ', 'StatuslineNormalMode' },
  ['R'] = { 'REPLACE ', 'StatuslineReplaceMode' },
  ['V'] = { 'V-LINE ', 'StatuslineVisualMode' },
  ['v'] = { 'VISUAL ', 'StatuslineVisualMode' },
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
  -- local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)

  local sections = {
    -- Left
    file_name,
    '%##',

    -- Center
    '%=',
    diagnostics_cached,
    '%=',

    -- Right
    file_syntax(),
    location(),
    mode()
  }

  return table.concat(sections)
end

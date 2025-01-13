local buf = -1
local win = -1

--- Opens a floating terminal window
local function open()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2) -- Center vertically

  if not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
  end

  win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = 'single',
    title = { { ' Terminal ', 'NormalFloat' } },
    title_pos = 'center',
  })

  if vim.bo[buf].buftype ~= 'terminal' then
    vim.cmd.terminal()
  end
end

--- Closes the floating terminal window and deletes its buffer
local function close()
  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
    win = -1
  end

  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
    buf = -1
  end
end

--- Hides the floating terminal window without deleting the buffer
local function hide()
  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_hide(win)
  end
end

--- Toggles the visibility of the floating terminal window
local function toggle()
  if vim.api.nvim_win_is_valid(win) then
    hide()
  else
    open()
  end
end

--- Command handler for managing the floating terminal
vim.api.nvim_create_user_command('Terminal', function(opts)
  local subcommand = opts.fargs[1]

  if subcommand == 'Toggle' then
    toggle()
  elseif subcommand == 'Hide' then
    hide()
  elseif subcommand == 'Open' then
    open()
  elseif subcommand == 'Close' then
    close()
  else
    vim.notify('Invalid subcommand: ' .. subcommand, vim.log.levels.ERROR)
    return
  end
end, {
  nargs = 1,
  complete = function()
    return { 'Toggle', 'Close', 'Open', 'Hide' }
  end,
})

local mru = require 'features.mru'


-- Closes the current buffer
local function close_buffer()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_buffer_type = vim.api.nvim_get_option_value('buftype', { buf = current_buffer })

  if current_buffer_type == 'terminal' or current_buffer_type == 'prompt' then
    vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
    return
  end

  if vim.api.nvim_get_option_value('filetype', { buf = current_buffer }) == 'NvimTree' then
    require('nvim-tree.api').tree.close()
    return
  end

  local next_buffer = mru.prev(current_buffer)

  if next_buffer then
    local ok, err = pcall(vim.api.nvim_set_current_buf, next_buffer)
    if not ok then
      vim.notify(
        string.format("buffer: failed to switch to buffer %d: %s", next_buffer, err),
        vim.log.levels.ERROR
      )
      return nil
    end
  else
    local api = require('nvim-tree.api')
    if api.tree.is_visible() then api.tree.focus() end
  end

  for _, client in pairs(vim.lsp.get_clients()) do
    if vim.lsp.buf_is_attached(current_buffer, client.id) then
      vim.lsp.buf_detach_client(current_buffer, client.id)
    end
  end

  vim.api.nvim_buf_delete(current_buffer, { force = true })
  mru.remove(current_buffer)
end

local function switch_buffer(direction)
  local current_buffer = vim.api.nvim_get_current_buf()
  local to_buffer = mru[direction](current_buffer)

  if to_buffer then
    local ok, err = pcall(vim.api.nvim_set_current_buf, to_buffer)
    if not ok then
      vim.notify(
        string.format("buffer: failed to switch to buffer %d: %s", to_buffer, err),
        vim.log.levels.ERROR
      )
      return nil
    end
  end
end

vim.api.nvim_create_user_command('Buffer', function(opts)
  local subcommand = opts.args

  if subcommand == 'close' then
    close_buffer()
  elseif subcommand == 'next' or subcommand == 'prev' then
    switch_buffer(subcommand)
  else
    return vim.notify('', vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  complete = function()
    return { 'close', 'next', 'prev' }
  end,
})

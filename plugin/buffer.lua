-- Gets a list of file buffers
local function get_file_buffers()
  local buffers = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.api.nvim_buf_is_valid(buf) then
      local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })

      if buftype ~= 'terminal' then
        table.insert(buffers, buf)
      end
    end
  end

  return buffers
end

-- Switches to the adjacent buffer
-- @param direction 'next' for the next buffer, 'prev' for the previous buffer
-- @return number | nil
--   Returns the buffer number of the adjacent buffer if successful
--   Returns nil if no adjacent buffer exists or an invalid direction is provided
local function switch_to_adjacent_buffer(direction)
  local buffers = get_file_buffers()

  if #buffers == 1 then return nil end

  local current_buffer = vim.api.nvim_get_current_buf()
  local target_buffer = nil

  for i, buf in ipairs(buffers) do
    if buf == current_buffer then
      if direction == 'prev' then
        target_buffer = (i > 1) and buffers[i - 1] or buffers[#buffers]
      elseif direction == 'next' then
        target_buffer = (i < #buffers) and buffers[i + 1] or buffers[1]
      else
        vim.notify('Invalid direction. Use `prev` or `next`', vim.log.levels.ERROR)
        return nil
      end

      break
    end
  end

  if target_buffer and vim.api.nvim_buf_is_loaded(target_buffer) then
    vim.api.nvim_set_current_buf(target_buffer)
    return target_buffer
  end

  return nil
end

-- Closes the current buffer
local function close_buffer()
  local current_buffer = vim.api.nvim_get_current_buf()
  local buffer_type = vim.api.nvim_get_option_value('buftype', { buf = current_buffer })

  if buffer_type == 'terminal' or buffer_type == 'prompt' then
    vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
    return
  end

  if vim.api.nvim_get_option_value('filetype', { buf = current_buffer }) == 'NvimTree' then
    if #get_file_buffers() == 0 then
      vim.api.nvim_set_current_buf(vim.api.nvim_create_buf(false, true))
    end

    require('nvim-tree.api').tree.toggle({ focus = false })
    -- require('nvim-tree.api').tree.close()
    return
  end

  local next_buffer = switch_to_adjacent_buffer('next')

  if not next_buffer then
    local api = require('nvim-tree.api')
    if api.tree.is_visible() then
      api.tree.focus()
    else
      vim.api.nvim_set_current_buf(vim.api.nvim_create_buf(false, true))
    end
  end

  for _, client in pairs(vim.lsp.get_clients()) do
    if vim.lsp.buf_is_attached(current_buffer, client.id) then
      vim.lsp.buf_detach_client(current_buffer, client.id)
    end
  end

  vim.api.nvim_buf_delete(current_buffer, { force = true })
end

vim.api.nvim_create_user_command('Buffer', function(opts)
  local subcommand = opts.args

  if subcommand == 'close' then
    close_buffer()
  elseif subcommand == 'next' or subcommand == 'prev' then
    switch_to_adjacent_buffer(subcommand)
  else
    vim.notify("Unknown command. Usage: :Buffer [close|next|prev]", vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  complete = function()
    return { 'close', 'next', 'prev' }
  end,
})

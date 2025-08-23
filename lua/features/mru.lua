local M = {
  items = {}
}

local config = {
  ignore_buftype = { 'nofile', 'prompt', 'quickfix' },
  ignore_filetype = { 'gitcommit', 'neo-tree', 'TelescopePrompt' },
  max_items = 50,
}

-- Check if value is in list
local function contains(list, value)
  for _, val in ipairs(list) do
    if val == value then return true end
  end

  return false
end

-- Determine if buffer is valid for MRU tracking
local function is_valid_buf(bufnr)
  if not vim.api.nvim_buf_is_loaded(bufnr) then return false end
  if vim.api.nvim_buf_get_name(bufnr) == '' then return false end

  local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')

  if contains(config.ignore_buftype, buftype) then return false end
  if contains(config.ignore_filetype, filetype) then return false end

  return true
end

-- Insert buffer number at the top of the MRU list
function M.insert(bufnr)
  if not is_valid_buf(bufnr) then return end

  M.remove(bufnr)

  table.insert(M.items, 1, bufnr)

  if #M.items > config.max_items then
    table.remove(M.items)
  end
end

-- Remove buffer number from the MRU list
function M.remove(bufnr)
  for i, path in ipairs(M.items) do
    if path == bufnr then
      table.remove(M.items, i)
      break
    end
  end
end

-- Return the buffer number that comes *after* the current one in the MRU list
function M.next(current_bufnr)
  if #M.items < 2 then return nil end

  for i, buf in ipairs(M.items) do
    if buf == current_bufnr then
      return M.items[(i - 2) % #M.items + 1]
    end
  end

  return nil
end

-- Return the buffer number that comes *before* the current one in the MRU list
function M.prev(current_bufnr)
  if #M.items < 2 then return nil end

  for i, buf in ipairs(M.items) do
    if buf == current_bufnr then
      return M.items[(i % #M.items) + 1]
    end
  end

  return nil
end

local mru_group = vim.api.nvim_create_augroup('MRU', { clear = true })

-- Keep the Most-Recently-Used (MRU) buffer list fresh
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Update MRU list on buffer enter',
  group = mru_group,
  callback = function(args)
    M.insert(args.buf)
  end
})

vim.api.nvim_create_autocmd('BufWipeout', {
  desc = 'Remove buffer from MRU on close',
  group = mru_group,
  callback = function(args)
    M.remove(args.buf)
  end
})

return M

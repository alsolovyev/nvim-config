--- Closes the current buffer
---
--- 1. If the current buffer is modified:
---    - Warns the user with a message (unless the `skip_modified_check` parameter is set to `true`).
--- 2. Attempts to switch to another valid buffer:
---    - Looks for a buffer that is not the current one and has no specific `buftype`.
--- 3. If no valid buffer is found:
---    - If NvimTree is visible, it focuses on the NvimTree window.
--- 4. Detaches all active LSP clients from the current buffer:
---    - Ensures no LSP operations are tied to the buffer before deletion.
--- 5. Deletes the current buffer:
---    - Safely deletes the buffer only if it is valid, without forcing the deletion.
---
--- @param skip_modified_check boolean If true, bypasses the unsaved changes check.
local function close_buffer(skip_modified_check)
  skip_modified_check = skip_modified_check or false

  if not skip_modified_check and vim.bo.modified then
    vim.notify('Buffer has unsaved changes', vim.log.levels.WARN)
    return
  end

  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  local next_buf = nil

  for _, buf in ipairs(buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == '' then
      if not vim.api.nvim_buf_get_name(buf):find('NvimTree_') then
        next_buf = buf
        break
      end
    end
  end

  if next_buf then
    vim.api.nvim_set_current_buf(next_buf)
  else
    local tree_api = require('nvim-tree.view')

    if tree_api.is_visible() then
      tree_api.focus()
    end
  end

  for _, client in pairs(vim.lsp.get_clients()) do
    if vim.lsp.buf_is_attached(current_buf, client.id) then
      vim.lsp.buf_detach_client(current_buf, client.id)
    end
  end

  if vim.api.nvim_buf_is_valid(current_buf) then
    vim.api.nvim_buf_delete(current_buf, { force = skip_modified_check })
  end
end

return close_buffer

-- https://neovim.io/doc/user/sign.html#%3Asign-place
--
-- :help signs
--

--- Define a new sign named or modify the attributes of an existing sign.
local function sign_define(hl, icon)
  -- https://neovim.io/doc/user/builtin.html#sign_define()
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- LSP
sign_define('DiagnosticSignError', '󰅙')
sign_define('DiagnosticSignInfo',  '󰋼')
sign_define('DiagnosticSignHint',  '󰌵')
sign_define('DiagnosticSignWarn',  '')

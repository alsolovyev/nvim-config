-- https://neovim.io/doc/user/lua#vim.keymap.set()
-- local set = vim.keymap.set

-- Remap
-- vim.g.mapleader = '\'
vim.keymap.set('',  '§', '<ESC>', { desc = 'Esc' })
vim.keymap.set('i', '§', '<ESC>', { desc = 'Esc' })

-- Exit insert mode
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Exit insert mode' })
vim.keymap.set('i', 'kk', '<ESC>', { desc = 'Exit insert mode' })

-- Do not yank
vim.keymap.set('n', 'x',     '"_x',     { desc = 'Delete character without yanking' })
vim.keymap.set('n', '<S-d>', '"_<S-d>', { desc = 'Delete until end of line without yanking' })

-- Buffers
vim.keymap.set({ 'n', 't' }, '<leader>q', '<CMD>Buffer close<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '[b', '<CMD>Buffer prev<CR>', { desc = 'Go to prev buffer in buffer list' })
vim.keymap.set('n', ']b', '<CMD>Buffer next<CR>', { desc = 'Go to next buffer in buffer list' })

-- Resize window
vim.keymap.set('n', '=', ':vertical   resize +5<CR>', { desc = 'Increase current window width  by 5', silent = true })
vim.keymap.set('n', '+', ':horizontal resize +5<CR>', { desc = 'Increase current window height by 5', silent = true })
vim.keymap.set('n', '-', ':vertical   resize -5<CR>', { desc = 'Decrease current window width  by 5', silent = true })
vim.keymap.set('n', '_', ':horizontal resize -5<CR>', { desc = 'Decrease current window height by 5', silent = true })

-- Tabs
vim.keymap.set('n', 'te',      ':tabedit<CR>', { desc = 'Open new tab', silent = true })
vim.keymap.set('n', '<S-Tab>', ':tabnext<CR>', { desc = 'Next tab',     silent = true })
vim.keymap.set('n', '<C-Tab>', ':tabprev<CR>', { desc = 'Previous tab', silent = true })

-- Move lines
vim.keymap.set('n', '<S-j>', ':m .+1<CR>==',     { desc = 'Move line down', silent = true })
vim.keymap.set('n', '<S-k>', ':m .-2<CR>==',     { desc = 'Move line up',   silent = true })
vim.keymap.set('v', '<S-j>', ":m '>+1<CR>gv=gv", { desc = 'Move line down', silent = true })
vim.keymap.set('v', '<S-k>', ":m '<-2<CR>gv=gv", { desc = 'Move line up',   silent = true })

-- Misc
vim.keymap.set('v', '<leader>s',  '<CMD>sort<CR>',   { desc = 'Sort lines in range', silent = true })
vim.keymap.set('n', '<leader>rn', '<CMD>Rename<CR>', { desc = 'Rename all occurrences of a word under the cursor' })

-- Terminal
vim.keymap.set({ 'n', 't' }, '<leader>ft', '<cmd>Terminal Toggle<CR>', { desc = 'Toggle terminal', silent = true })

-- Telescope
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>',    { desc = '', silent = true })
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = '', silent = true })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>',  { desc = '', silent = true })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>',  { desc = '', silent = true })

-- ToDo Comments
vim.keymap.set('n', '<leader>td', ':TodoTelescope<CR>', { desc = '', silent = true })

-- Nvim-tree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle explorer', silent = true })

-- Gitsigns
vim.keymap.set('n', '<leader>gl', ':Gitsigns toggle_linehl<CR>', { desc = 'Enable/disable gitsigns line highlights', silent = true })
vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>',  { desc = 'Preview the hunk at the cursor position in a floating window', silent = true })
vim.keymap.set('n', '<leader>gt', ':Gitsigns toggle_signs<CR>',  { desc = 'Enable/disable gitsigns', silent = true })
vim.keymap.set({ 'n', 'v' }, '[g', ':Gitsigns prev_hunk<CR>',               { desc = 'Jump to the previous hunk in the current buffer', silent = true })
vim.keymap.set({ 'n', 'v' }, ']g', ':Gitsigns next_hunk<CR>',               { desc = 'Jump to the next hunk in the current buffer', silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ga', ':Gitsigns stage_hunk<CR>',      { desc = 'Stage the hunk at the cursor position, or all lines in the given range', silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gb', ':Gitsigns blame_line<CR>',      { desc = 'Run git blame on the current line and show the results in a floating window', silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Adds an unobtrusive and customisable blame annotation at the end of the current line',         silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>',      { desc = 'Reset the lines of the hunk at the cursor position, or all lines in the given range', silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gu', ':Gitsigns undo_stage_hunk<CR>', { desc = 'Undo the last call of stage_hunk', silent = true })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings
    vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,       { desc = 'Move to the previous diagnostic', buffer = ev.buf,  silent = true })
    vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,       { desc = 'Move to the next diagnostic', buffer = ev.buf, silent = true })
    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration,        { desc = 'Go to the declaration', buffer = ev.buf, silent = true })
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition,         { desc = 'Jump to the definition', buffer = ev.buf, silent = true })
    vim.keymap.set('n', '<leader>h',  vim.lsp.buf.hover,              { desc = 'Displays information about the symbol under the cursor', buffer = ev.buf, silent = true })
    vim.keymap.set('n', '<leader>H',  vim.lsp.buf.document_highlight, { desc = 'Highlight symbol under the cursor', buffer = ev.buf, silent = true })
    vim.keymap.set('n', '<leader>Hr', vim.lsp.buf.clear_references,   { desc = 'Removes document highlights from current buffer', buffer = ev.buf, silent = true })
    vim.keymap.set('n', '<leader>oD', vim.diagnostic.setloclist,      { desc = 'Add buffer diagnostics to the location list', buffer = ev.buf, silent = true })
    vim.keymap.set('n', '<leader>od', vim.diagnostic.open_float,      { desc = 'Open diagnostic in a float window', buffer = ev.buf, silent = true })

    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,   { desc = 'Open code actions', buffer = ev.buf, silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>cf', require('conform').format, { desc = 'Format a buffer using the attached LSP', buffer = ev.buf, silent = true })
  end,
})

-- Open URL
vim.keymap.set('n', 'gx', require 'features.open-url', { desc = 'Open URL', silent = true })

-- Refactor
vim.keymap.set({'n', 'v'}, '<leader>rs', ':RemoveSpaces<CR>', { desc = 'Remove whitespace/newlines not in quotes (range-aware)', silent = true })

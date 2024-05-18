-- https://neovim.io/doc/user/options
--
-- :help option-list - list of options with short description
-- :help E355 - list of options with full description
--

-- Common
vim.opt.colorcolumn = '80'
-- vim.o.inccommand = 'split'
-- vim.o.list = true
vim.o.listchars = 'eol:↲,extends:»,nbsp:␣,precedes:«,space:·,tab:→ ,trail:·'
vim.o.scrolloff = 999
-- vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wrap = false

-- Statusline
vim.g.gf_disable_statusline = 1
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.statusline = "%!v:lua.require('features.statusline')()"

-- Backup/Tmp Files
vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = false
vim.o.writebackup = false

-- Highlight
vim.o.cursorline = true
vim.o.cursorlineopt = 'both'
vim.o.termguicolors = true

-- Cursor
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:hor20,r-cr-o:hor20'

-- Title
vim.o.title = true
vim.o.titlestring = '%t'

-- Search
vim.o.ignorecase = true
vim.o.showmatch = true
vim.o.smartcase = true

-- Tabs\Indent
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false

-- Others
vim.o.updatetime = 250

-- Files
vim.opt.path:append({ '**' })
vim.opt.wildignore:append({ '*/node_modules/*' })

-- Plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable default providers
vim.g["loaded_node_provider"] = 0
vim.g["loaded_python3_provider"] = 0
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_ruby_provider"] = 0

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append '<>[]hl'

-- Disable nvim intro
vim.opt.shortmess:append 'sI'

-- Add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath 'data'
    .. '/mason/bin'
    .. (vim.fn.has 'win32' ~= 0 and ';' or ':')
    .. vim.env.PATH

-- Disable vim's welcome page
vim.opt.shortmess:append("sI")

-- Enable line number and relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- Split below and right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Sets how neovim will display certain whitespace in the editor
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Max number of entries in the completion menu
vim.opt.pumheight = 6

-- Disable line wrap
vim.opt.wrap = false

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Minimal number of colums before and after the cursor
vim.opt.scrolloff = 10

-- Enable undofile
vim.opt.undofile = true

-- Fix visual block
vim.opt.virtualedit = "block"

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 80ch column
vim.opt.colorcolumn = "80"

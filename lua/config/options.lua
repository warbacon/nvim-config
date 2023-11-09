-- Disable vim's welcome page
vim.opt.shortmess:append("sI")

-- Enable undofile
vim.opt.undofile = true

-- Minimal number of lines/colums before and after the cursor
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Max number of entries in the completion menu
vim.opt.pumheight = 10

-- Enable line number and relativenumber
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable signcolumn for gitsigns and code warnings
vim.opt.signcolumn = "yes"

-- Confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Split below and right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable line wrap
vim.opt.wrap = false

-- Decrease update time
vim.opt.updatetime = 200

-- Decrease keymap timeout length
vim.opt.timeoutlen = 300

-- Sets the colorcolumn to 80 characters
vim.opt.colorcolumn = "80"

-- Disable vim's welcome page
vim.opt.shortmess:append("sI")

-- Enable undofile
vim.o.undofile = true

-- Minimal number of lines/colums before and after the cursor
vim.o.scrolloff = 8
vim.o.sidescrolloff = 4

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Max number of entries in the completion menu
vim.o.pumheight = 10

-- Enable line number and relativenumber
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable signcolumn for gitsigns and code warnings
vim.wo.signcolumn = "yes"

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Split below and right
vim.o.splitbelow = true
vim.o.splitright = true

-- Disable line wrap
vim.o.wrap = false

-- Decrease update time
vim.o.updatetime = 250

-- Sets the colorcolumn to 80 characters
vim.o.colorcolumn = "80"

vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = "yes"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = -1
vim.o.expandtab = true

vim.o.pumheight = 10

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.undofile = true

vim.o.cursorline = true
vim.o.cursorlineopt = "number"

vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "+" }

vim.o.sidescrolloff = 3
vim.o.scrolloff = 5
vim.o.wrap = false

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.foldtext = ""
vim.o.winborder = "rounded"

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.opt.shortmess:append("I")

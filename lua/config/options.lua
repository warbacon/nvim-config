vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4

vim.opt.scrolloff = 999
vim.opt.sidescroll = 5
vim.opt.wrap = false

vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

vim.opt.virtualedit = "block"

vim.opt.shortmess:append({ I = true })

vim.opt.signcolumn = "yes"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

vim.opt.colorcolumn = "80"

vim.opt.pumheight = 10

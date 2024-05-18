-- Enable line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable persistent undo with undo files
vim.opt.undofile = true

-- Set split windows to open below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set a column indicator at 80 characters
vim.opt.colorcolumn = "80"

-- Set popup menu height
vim.opt.pumheight = 10

-- Use spaces for tabs and configure indentation settings
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4

-- Set scrolloff and sidescroll settings
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 3
vim.opt.wrap = false

-- Enable block mode for virtual editing
vim.opt.virtualedit = "block"

-- Customize messages and display options
vim.opt.shortmess:append({ I = true })
vim.opt.signcolumn = "yes"

-- Ignore case in searches unless an uppercase letter is included
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable visible whitespace and customize characters
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Customize display of various elements
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- Git signs in statuscolumn
vim.opt.statuscolumn = [[%!v:lua.require("util").statuscolumn()]]

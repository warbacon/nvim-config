-- Set the leader key to space and the local leader key to backslash
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Always show the sign column
vim.o.signcolumn = "yes"

-- Enable line numbers and relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Highlight the line number of the cursor's line
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Use spaces instead of tabs and set indentation size
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Customize fill characters
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- Open new splits below and to the right of the current window
vim.o.splitbelow = true
vim.o.splitright = true

-- Ignore case in search patterns, but enable smart case
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show whitespace characters like tabs, trailing spaces, and non-breakable spaces
vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "+" }

-- Do not show the intro message on startup
vim.opt.shortmess:append({ I = true })

-- Enable persistent undo, allowing undo history to be saved between sessions
vim.o.undofile = true

-- Disable line wrapping
vim.o.wrap = false

-- Set minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 3
vim.o.scrolloff = 5

-- Limit the height of the popup menu
vim.o.pumheight = 10

-- Set leader key to space and local leader key to backslash
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Enable line numbers and relative line numbers
opt.number = true
opt.relativenumber = true

-- Disable the intro screen
opt.shortmess:append({ I = true })

-- Display symbols for trailing spaces
opt.list = true
opt.listchars = { tab = "  ", trail = "·", nbsp = "+" }

-- Configure fill characters for diff and end-of-buffer
opt.fillchars = {
    diff = "╱",
    eob = " ",
}

-- Highlight the line number of the current line
opt.cursorline = true
opt.cursorlineopt = "number"

-- Prompt for confirmation when exiting unsaved
opt.confirm = true

-- Set indentation options
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4

-- Ignore case in searches unless uppercase is used
opt.ignorecase = true
opt.smartcase = true

-- Open new splits below and to the right
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- Allow virtual editing in block mode
opt.virtualedit = "block"

-- Enable persistent undo
opt.undofile = true

-- Disable line wrapping
opt.wrap = false

-- Set scroll padding
opt.sidescrolloff = 3
opt.scrolloff = 5

-- Decrease update time for better responsiveness
opt.updatetime = 200

-- Limit the number of items in the pop-up menu
opt.pumheight = 10

-- Configure Netrw settings
vim.g.netrw_banner = 0

-- Disable external providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

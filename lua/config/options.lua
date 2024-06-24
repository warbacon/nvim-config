-- Set leader key to space and local leader key to backslash
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Configure Netrw settings
vim.g.netrw_banner = 0

-- Disable external providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Enable line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable the intro screen
vim.opt.shortmess:append({ I = true })

-- Display symbols for trailing spaces
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "+" }

-- Configure fill characters for diff and end-of-buffer
vim.opt.fillchars = {
    diff = "╱",
    eob = " ",
}

-- Highlight the line number of the current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Prompt for confirmation when exiting unsaved
vim.opt.confirm = true

-- Set indentation vim.options
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4

-- Ignore case in searches unless uppercase is used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Open new splits below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"

-- Allow virtual editing in block mode
vim.opt.virtualedit = "block"

-- Enable persistent undo
vim.opt.undofile = true

-- Disable line wrapping
vim.opt.wrap = false

-- Set scroll padding
vim.opt.sidescrolloff = 3
vim.opt.scrolloff = 5

-- Decrease update time for better responsiveness
vim.opt.updatetime = 200

-- Limit the number of items in the pop-up menu
vim.opt.pumheight = 10

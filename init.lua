-- Set leader-key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable banner in netrw
vim.g.netrw_banner = 0

-- Remove the "How-to disable mouse" menu item and the separator above it
vim.cmd([[
aunmenu PopUp.How-to\ disable\ mouse
aunmenu PopUp.-1-
]])

-- Options
require("config.options")

-- Autocmds
require("config.autocmds")

-- Keymaps
require("config.keymaps")

-- Plugins
require("config.lazy")

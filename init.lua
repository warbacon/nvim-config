-- Set leader-key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
require("config.options")

-- Autocmds
require("config.autocmds")

-- Keymaps
require("config.keymaps")

-- Plugins
require("config.lazy")

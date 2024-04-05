-- Set leader-key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
require("config.options")

-- Autocmds
require("config.autocmds")

-- Keymaps
require("config.keymaps")

-- Miscellaneous
require("config.misc")

-- Plugins
require("config.lazy")

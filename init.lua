-- Load configuration options
require("config.options")

-- Load custom autocommands
require("config.autocmds")

-- Load key mappings configuration
require("config.keymaps")

-- Load plugins
require("config.lazy")

-- Remove "How to disable mouse" entry in popup-menu
vim.cmd([[
aunmenu PopUp.How-to\ disable\ mouse
aunmenu PopUp.-1-
]])

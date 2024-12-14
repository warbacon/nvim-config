-- Load utils
_G.util = require("util")

-- Load configuration options
require("config.options")

-- Load custom autocommands
require("config.autocmds")

-- Load key mappings configuration
require("config.keymaps")

-- Load extra configurations
require("config.extra")

-- Load plugins
require("config.lazy")

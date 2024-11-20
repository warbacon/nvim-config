-- Diagnostics configuration
local diagnostic_icons = require("util.icons").diagnostics
vim.diagnostic.config({
    signs = {
        text = diagnostic_icons,
    },
})

-- Diagnostics configuration
local diagnostic_icons = require("util.icons").diagnostics
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
            [vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
            [vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
            [vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
        },
    },
})

-- Diagnostics configuration
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = require("util.icons").diagnostics.ERROR,
            [vim.diagnostic.severity.WARN] = require("util.icons").diagnostics.WARN,
            [vim.diagnostic.severity.INFO] = require("util.icons").diagnostics.INFO,
            [vim.diagnostic.severity.HINT] = require("util.icons").diagnostics.HINT,
        },
    },
})

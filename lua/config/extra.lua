-- Configure diagnostics
vim.diagnostic.config({
    severity_sort = true,
    signs = {
        text = require("util.icons").diagnostics,
    },
})

-- Remove the `How to disable mouse` entry from the PopUp menu
vim.cmd([[
unmenu PopUp.-2-
unmenu PopUp.How-to\ disable\ mouse
]])

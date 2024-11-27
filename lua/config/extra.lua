-- Configure diagnostics
vim.diagnostic.config({
    severity_sort = true,
    signs = {
        text = require("util.icons").diagnostics,
    },
})

-- Remove the `How to disable mouse` entry from the PopUp menu
vim.cmd([[
if has("nvim-0.11")
    unmenu PopUp.-2-
else
    unmenu PopUp.-1-
endif
unmenu PopUp.How-to\ disable\ mouse
]])

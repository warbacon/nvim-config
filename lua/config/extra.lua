-- Bigfile support
vim.filetype.add({
    pattern = {
        [".*"] = {
            function(path, buf)
                return vim.bo[buf]
                        and vim.bo[buf].filetype ~= "bigfile"
                        and path
                        and vim.fn.getfsize(path) > 1024 * 1024 * 1.5 -- 1.5 MB
                        and "bigfile"
                    or nil
            end,
        },
    },
})

-- Diagnostics configuration
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "󰋽",
        },
    },
})

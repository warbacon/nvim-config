vim.bo.textwidth = 80

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.bo.formatexpr = ""
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.wo.colorcolumn = vim.bo.filetype == "markdown" and "80" or ""
    end,
})

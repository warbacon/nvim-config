vim.bo.textwidth = 80

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.wo.colorcolumn = vim.bo.filetype == "markdown" and "80" or ""
        vim.wo.conceallevel = vim.bo.filetype == "markdown" and 3 or 0
    end,
})

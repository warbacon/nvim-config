return {
    "echasnovski/mini.indentscope",
    event = "LazyFile",
    init = function()
        local filetype_exclude = { "markdown", "help", "oil" }
        vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
            callback = function()
                if vim.bo.buftype == "nofile" or vim.tbl_contains(filetype_exclude, vim.bo.filetype) then
                    vim.b.miniindentscope_disable = true
                end
            end,
        })
    end,
    opts = {
        symbol = "▏",
        options = { border = 'top' }
    },
}

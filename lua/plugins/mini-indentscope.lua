return {
    "echasnovski/mini.indentscope",
    event = "LazyFile",
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "help" },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
    opts = function()
        return {
            symbol = "▏",
        }
    end,
}

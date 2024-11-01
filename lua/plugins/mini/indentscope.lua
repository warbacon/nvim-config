return {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
        return {
            draw = {
                delay = 0,
                animation = require("mini.indentscope").gen_animation.none()
            },
            symbol = "▏",
        }
    end,
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "lazy",
                "mason",
            },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
}

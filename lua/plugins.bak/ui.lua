return {
    -- TOKYONIGHT ==============================================================
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup()
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- INDENT-BLANKLINE ========================================================
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = {
                char = "▏",
                smart_indent_cap = true,
            },
            scope = {
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "lazy",
                    "mason",
                    "fidget",
                    "lazyterm",
                },
            },
        },
    },
}

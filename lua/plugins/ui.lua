return {
    -- TOKYONIGHT ==============================================================
    { "folke/tokyonight.nvim", priority = 1000, opts = {} },

    -- INDENT-BLANKLINE ========================================================
    {
        "lukas-reineke/indent-blankline.nvim",
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

    -- MINI.ICONS ==============================================================
    {
        "echasnovski/mini.icons",
        lazy = true,
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
}

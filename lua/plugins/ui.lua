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

    -- HLCHUNK =================================================================
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            chunk = {
                enable = true,
                duration = 0,
                delay = 0,
                error_sign = false,
                textobject = "ic",
                style = "#00ffff",
                chars = {
                    left_top = "┌",
                    left_bottom = "└",
                    right_arrow = "─",
                },
            },
            indent = { enable = true },
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
        opts = {},
    },
}

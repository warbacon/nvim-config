return {
    -- CATPPUCCIN -------------------------------------------------------------
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            styles = { booleans = { "bold" } },
            custom_highlights = function(colors)
                return {
                    CursorLine = { bg = colors.none },
                }
            end,
            integrations = {
                mason = true,
                native_lsp = {
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "mawkler/modicator.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.cursorline = true
        end,
        opts = {},
    },
}

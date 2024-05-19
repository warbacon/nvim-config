return {
    -- CATPPUCCIN --------------------------------------------------------------
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            styles = { booleans = { "bold" } },
            custom_highlights = function(colors)
                return {
                    Cursor2 = { fg = colors.green, bg = colors.green },
                    IndentLineCurrent = { fg = colors.sky },
                }
            end,
            integrations = {
                fidget = true,
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
            vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block-Cursor2/lCursor2,r-cr-o:hor20"
        end,
    },
}

return {
    -- TOKYONIGHT.NVIM =========================================================
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "moon",
            on_highlights = function(hl)
                hl.ModeMsg = hl.CursorLineNr
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- CATPPUCCIN ==============================================================
    {
        "catppuccin/nvim",
        enabled = false,
        name = "catppuccin",
        priority = 1000,
        opts = {
            styles = { booleans = { "bold" } },
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
        end,
    },
}

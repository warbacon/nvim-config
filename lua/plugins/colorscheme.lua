return {
    -- KANAGAWA.NVIM ===========================================================
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        opts = {
            compile = true,
            colors = {
                theme = { all = { ui = { bg_gutter = "none" } } },
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    TelescopePromptBorder = { fg = theme.syn.constant },
                }
            end,
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd.colorscheme("kanagawa")
        end,
    },
}

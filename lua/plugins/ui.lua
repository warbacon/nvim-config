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

    -- INDENT-BLANKLINE.NVIM ===================================================
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "LazyFile",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { show_start = false, show_end = false },
            exclude = {
                filetypes = {
                    "help",
                    "lazy",
                    "mason",
                },
            },
        },
    },

    -- STATUSCOL.NVIM ==========================================================
    {
        "luukvbaal/statuscol.nvim",
        opts = function()
            local builtin = require("statuscol.builtin")
            return {
                ft_ignore = { "netrw" },
                segments = {
                    { sign = { namespace = { "diagnostic/signs" } } },
                    { text = { builtin.lnumfunc } },
                    { sign = { namespace = { "gitsigns" } } },
                },
            }
        end,
    },

    -- NVIM-WEB-DEVICONS =======================================================
    { "nvim-tree/nvim-web-devicons", lazy = true },
}

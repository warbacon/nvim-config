return {
    -- TOKYONIGHT.NVIM =========================================================
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- DRESSING.NVIM ===========================================================
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    -- INDENT-BLANKLINE.NVIM ===================================================
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "File",
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
                ft_ignore = {
                    "netrw",
                    "lazy",
                },
                relculright = true,
                segments = {
                    { sign = { namespace = { "diagnostic/signs" } } },
                    { text = { builtin.lnumfunc } },
                    { text = { " " } },
                    { sign = { namespace = { "gitsigns" }, colwidth = 1 } },
                },
            }
        end,
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

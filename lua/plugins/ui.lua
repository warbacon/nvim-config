return {
    -- TOKYONIGHT.NVIM =========================================================
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("tokyonight").setup({
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                },
            })
            vim.cmd.colorscheme("tokyonight")
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
        opts = {
            file = {
                ["kitty.conf"] = { glyph = "󰄛", hl = "MiniIconsYellow" },
            },
            filetype = {
                fish = { glyph = "󰈺", hl = "MiniIconsYellow" },
            },
            lsp = {
                copilot = { glyph = "", hl = "MiniIconsPurple" },
            },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
}

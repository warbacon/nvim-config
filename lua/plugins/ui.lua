return {
    -- NOICE.NVIM -------------------------------------------------------------
    {
        "folke/noice.nvim",
        enabled = false,
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        init = function()
            vim.opt.cmdheight = 0
        end,
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            cmdline = {
                view = "cmdline",
            },
            signature = {
                auto_open = {
                    enabled = false,
                },
            },
        },
    },
    -- LUALINE.NVIM -----------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        enabled = false,
        event = "VeryLazy",
        dependencies = "nvim-tree/nvim-web-devicons",
        init = function()
            vim.opt.statusline = " "
            vim.opt.showmode = false
        end,
        opts = {
            options = {
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 1, right = 0 },
                    },
                    {
                        "filename",
                        path = 1,
                        symbols = {
                            modified = "[+]",
                            readonly = "[RO]",
                            unnamed = "[Sin nombre]",
                            newfile = "[Nuevo]",
                        },
                    },
                },
                lualine_x = {
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.command.has()
                        end,
                        color = { fg = require("catppuccin.palettes").get_palette("mocha").mauve },
                    },
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.mode.has()
                        end,
                        color = { fg = require("catppuccin.palettes").get_palette("mocha").peach },
                    },
                    "diagnostics",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_c = {
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 1, right = 0 },
                    },
                    {
                        "filename",
                        path = 1,
                        symbols = {
                            modified = "[+]",
                            readonly = "[RO]",
                            unnamed = "[Sin nombre]",
                            newfile = "[Nuevo]",
                        },
                    },
                },
            },
        },
    },
}

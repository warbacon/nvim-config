return {
    -- LUALINE.NVIM -----------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        enabled = false,
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
                lualine_x = { "diagnostics" },
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

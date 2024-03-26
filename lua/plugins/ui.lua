---@diagnostic disable: undefined-field
return {
    -- NOICE.NVIM -------------------------------------------------------------
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = "MunifTanjim/nui.nvim",
        init = function()
            vim.opt.cmdheight = 0
            vim.opt.showmode = false
        end,
        keys = {
            {
                "<leader>nh",
                function()
                    require("noice").cmd("telescope")
                end,
                mode = "n",
            },
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                signature = { auto_open = { enabled = false } },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
            },
        },
    },

    -- LUALINE.NVIM -----------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = "nvim-tree/nvim-web-devicons",
        init = function()
            vim.opt.statusline = " "
            vim.opt.laststatus = 3
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
                            modified = "●",
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
        },
    },

    -- INCLINE.NVIM -----------------------------------------------------------
    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        config = function()
            local devicons = require("nvim-web-devicons")
            require("incline").setup({
                window = {
                    margin = {
                        horizontal = 0,
                        vertical = 0,
                    },
                },
                hide = {
                    only_win = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if filename == "" then
                        filename = "[Sin nombre]"
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                        ft_icon and { " ", ft_icon, " ", guifg = ft_color } or "",
                        " ",
                        filename,
                        modified and " ●" or "",
                        " ",
                    }
                end,
            })
        end,
    },
}

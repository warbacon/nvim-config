return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.statusline = " "
    end,
    opts = function()
        ---@type fun(name: string): table
        local function get_highlight(name)
            local hl = vim.api.nvim_get_hl(0, { name = name, link = false })

            local function to_hex(color)
                return color and string.format("#%06x", color) or nil
            end

            return {
                fg = to_hex(hl.fg),
                bg = to_hex(hl.bg),
            }
        end

        local colors = {
            cyan = get_highlight("Special").fg,
            bright_bg = get_highlight("CursorLine").bg,
        }

        return {
            options = {
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = {
                    {
                        function()
                            return " "
                        end,
                        draw_empty = true,
                        padding = { left = 0, right = 0 },
                    },
                },
                lualine_b = {},
                lualine_c = {
                    {
                        function()
                            return " "
                        end,
                        draw_empty = true,
                        padding = { left = 0, right = 0 },
                    },
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 0, right = 0 },
                    },
                    {
                        "filename",
                        ---@param text string
                        fmt = function(text)
                            if vim.bo.buftype == "help" then
                                text = vim.fn.fnamemodify(text, ":t")
                            end
                            return text
                        end,
                        path = 1,
                        padding = { left = 0 },
                        symbols = {
                            modified = "[+]",
                            readonly = "[-]",
                            unnamed = "[Sin nombre]",
                            newfile = "[Nuevo]",
                        },
                    },
                },
                lualine_x = {
                    "diagnostics",
                    function()
                        return "%-8.(%l:%c%V%)"
                    end,
                    {
                        function()
                            local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
                            local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                            local lines = vim.api.nvim_buf_line_count(0)
                            local i = math.ceil(curr_line / lines * #sbar)
                            return string.rep(sbar[i], 2)
                        end,
                        padding = { left = 0, right = 0 },
                        color = { fg = colors.cyan, bg = colors.bright_bg },
                    },
                },
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 0, right = 0 },
                        colored = false,
                    },
                    {
                        "filename",
                        ---@param text string
                        fmt = function(text)
                            if vim.bo.buftype == "help" then
                                text = vim.fn.fnamemodify(text, ":t")
                            end
                            return text
                        end,
                        path = 1,
                        padding = { left = 0 },
                        color = { gui = "" },
                        symbols = {
                            modified = "[+]",
                            readonly = "[-]",
                            unnamed = "[Sin nombre]",
                            newfile = "[Nuevo]",
                        },
                    },
                },
                lualine_c = {},
                lualine_x = {
                    function()
                        return "%-8.(%l:%c%V%)"
                    end,
                    {
                        function()
                            local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
                            local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                            local lines = vim.api.nvim_buf_line_count(0)
                            local i = math.floor((curr_line - 1) / lines * #sbar) + 1
                            return string.rep(sbar[i], 2)
                        end,
                        padding = { left = 0, right = 0 },
                    },
                },
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}

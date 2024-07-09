return {
    -- TOKYONIGHT.NVIM =========================================================
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup()
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

    -- HEIRLINE.NVIM ===========================================================
    {
        "rebelot/heirline.nvim",
        event = "UiEnter",
        init = function()
            vim.opt.statusline = " "
        end,
        config = function()
            local conditions = require("heirline.conditions")
            local utils = require("heirline.utils")

            local Space = { provider = " " }
            local Align = { provider = "%=" }

            local colors = {
                statusline_fg = utils.get_highlight("StatusLine").fg,
                statusline_bg = utils.get_highlight("StatusLine").bg,
                statuslinenc_fg = utils.get_highlight("StatusLineNC").fg,
                statuslinenc_bg = utils.get_highlight("StatusLineNC").bg,
                red = utils.get_highlight("ErrorMsg").fg,
                green = utils.get_highlight("String").fg,
                blue = utils.get_highlight("Function").fg,
                orange = utils.get_highlight("Constant").fg,
                purple = utils.get_highlight("Statement").fg,
                cyan = utils.get_highlight("Special").fg,
            }

            local ViMode = {
                init = function(self)
                    self.mode = vim.fn.mode(1)
                end,
                static = {
                    mode_colors = {
                        n = "blue",
                        i = "green",
                        v = "purple",
                        V = "purple",
                        ["\22"] = "purple",
                        c = "orange",
                        s = "cyan",
                        S = "cyan",
                        ["\19"] = "cyan",
                        R = "orange",
                        r = "orange",
                        ["!"] = "red",
                        t = "blue",
                    },
                },
                provider = function()
                    return " "
                end,
                hl = function(self)
                    local mode = self.mode:sub(1, 1)
                    return { bg = self.mode_colors[mode] }
                end,
                update = {
                    "ModeChanged",
                    pattern = "*:*",
                    callback = vim.schedule_wrap(function()
                        vim.cmd("redrawstatus")
                    end),
                },
            }

            local FileNameBlock = {
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(0)
                end,
            }

            local FileIcon = {
                init = function(self)
                    if vim.fn.isdirectory(self.filename) then
                        self.icon, self.hl, self.is_default = require("mini.icons").get("file", self.filename)
                        if self.is_default then
                            self.icon, self.hl, self.is_default = require("mini.icons").get("directory", self.filename)
                        end
                    end
                end,
                provider = function(self)
                    return self.is_default == false and self.icon .. " "
                end,
                hl = function(self)
                    return self.hl
                end,
            }

            local FileName = {
                provider = function(self)
                    local filename = vim.fn.fnamemodify(self.filename, ":.")
                    if vim.fn.has("win32") == 1 then
                        filename = filename:gsub("/", "\\")
                    end
                    filename = filename:gsub(vim.env.HOME, "~")
                    if filename == "" then
                        return "[Sin nombre]"
                    end
                    if not conditions.width_percent_below(#filename, 0.40) then
                        filename = vim.fn.pathshorten(filename)
                    end
                    return filename
                end,
            }

            local FileFlags = {
                {
                    condition = function()
                        return vim.bo.modified
                    end,
                    provider = "[+]",
                },
                {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = "󰌾",
                    hl = { fg = "red" },
                },
            }

            FileNameBlock = utils.insert(FileNameBlock, FileIcon, FileName, Space, FileFlags, { provider = "%<" })

            local Ruler = {
                provider = "%l,%c%V",
            }

            local ScrollBar = {
                static = {
                    sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
                },
                provider = function(self)
                    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                    local lines = vim.api.nvim_buf_line_count(0)
                    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                    return self.sbar[i] and string.rep(self.sbar[i], 2)
                end,
                hl = { fg = "blue" },
            }

            local StatusLine = {
                ViMode,
                Space,
                FileNameBlock,
                Align,
                Ruler,
                Space,
                ScrollBar,
                hl = { fg = "statusline_fg", bg = "statusline_bg" },
            }

            local StatusLineNC = {
                condition = function()
                    return conditions.is_not_active()
                end,
                FileNameBlock,
                Align,
                Ruler,
                Space,
                ScrollBar,
                hl = { fg = "statuslinenc_fg", bg = "statuslinenc_bg", force = true },
            }

            local StatusLines = {
                fallthrough = false,
                StatusLineNC,
                StatusLine,
            }

            require("heirline").setup({
                opts = {
                    colors = colors,
                },
                statusline = StatusLines,
            })
        end,
    },

    -- MINI.ICONS ==============================================================
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {},
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
}

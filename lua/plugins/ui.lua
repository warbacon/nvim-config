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
                char = "🭰",
                tab_char = "🭰",
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
        enabled = false,
        config = function()
            local conditions = require("heirline.conditions")
            local utils = require("heirline.utils")

            local Space = { provider = " " }
            local Align = { provider = "%=" }

            local MiniIcons = require("mini.icons")

            local colors = {
                bright_bg = utils.get_highlight("Folded").bg,
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
                    self.fullpath = vim.api.nvim_buf_get_name(0)
                    self.path = vim.fn.expand("%")
                    if vim.bo.filetype == "netrw" then
                        self.path = vim.fn.fnamemodify(self.path, ":~")
                    end
                    self.stat = self.fullpath ~= "" and vim.uv.fs_stat(self.fullpath)
                end,
            }

            local FileIcon = {
                init = function(self)
                    self.icon, self.hl, _ = MiniIcons.get("file", self.fullpath)
                    if self.stat and self.stat.type == "directory" then
                        self.icon, self.hl, _ = MiniIcons.get("directory", self.fullpath)
                    end
                end,
                condition = function(self)
                    return vim.bo.buftype == "" or self.icon ~= MiniIcons.get("file", "default")
                end,
                provider = function(self)
                    return self.icon .. " "
                end,
                hl = function(self)
                    return self.hl
                end,
            }

            local DirName = {
                provider = function(self)
                    if self.path == "" then
                        return
                    end

                    local dirname = vim.fs.dirname(self.path)

                    if dirname == "." then
                        return
                    end

                    if dirname ~= "/" then
                        dirname = dirname .. "/"
                    end

                    if vim.fn.has("win32") == 1 then
                        dirname = dirname:gsub("/", "\\")
                    end

                    if not conditions.width_percent_below(#dirname, 0.30) then
                        dirname = vim.fn.pathshorten(dirname)
                    end
                    return dirname
                end,
            }

            local FileName = {
                provider = function(self)
                    self.filename = vim.fs.basename(self.path)
                    return self.filename ~= "" and self.filename or vim.bo.filetype ~= "netrw" and "[Sin nombre]"
                end,
                hl = function()
                    if vim.bo.modified then
                        return { fg = "orange", bold = true }
                    end
                    return { fg = "None", bold = true }
                end,
            }

            local FileFlags = {
                {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = "󰌾",
                    hl = { fg = "red" },
                },
            }

            FileNameBlock =
                utils.insert(FileNameBlock, FileIcon, DirName, FileName, Space, FileFlags, { provider = "%<" })

            local Ruler = {
                provider = "%l,%c%V",
            }

            local ScrollBar = {
                static = {
                    sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
                },
                provider = function(self)
                    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                    local lines = vim.api.nvim_buf_line_count(0)
                    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                    return self.sbar[i] and string.rep(self.sbar[i], 2)
                end,
                hl = { fg = "blue", bg = "bright_bg" },
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

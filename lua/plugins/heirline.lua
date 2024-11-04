return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.statusline = " "
        vim.o.showmode = false
    end,
    config = function()
        local utils = require("heirline.utils")
        local conditions = require("heirline.conditions")
        local Space = { provider = " " }
        local Align = { provider = "%=" }
        local LeftSeparator = { provider = "  " }

        local FileNameBlock = {
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
            end,
        }

        local FileIcon = {
            init = function(self)
                local filename = self.filename
                self.icon, self.hl = require("mini.icons").get("file", filename)
            end,
            provider = function(self)
                return self.icon and (self.icon .. " ")
            end,
            hl = function(self)
                return { fg = self.icon_color }
            end,
            condition = function()
                return vim.bo.filetype ~= ""
            end,
        }

        local FileName = {
            provider = function(self)
                if self.filename == "" then
                    return "[Sin nombre]"
                end

                if vim.bo.buftype == "help" then
                    return vim.fn.fnamemodify(self.filename, ":t")
                end

                local filename = vim.fn.fnamemodify(self.filename, ":.")

                if not conditions.width_percent_below(#filename, 0.45) then
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
                provider = " ●",
            },
            {
                condition = function()
                    return vim.bo.readonly
                end,
                provider = " 󰌾",
                hl = "DiagnosticError",
            },
        }

        FileNameBlock = utils.insert(FileNameBlock, FileIcon, FileName, FileFlags, { provider = "%<" })

        local Commands = {
            {
                provider = require("noice").api.status.command.get,
                hl = utils.get_highlight("Statement"),
            },
            LeftSeparator,
            condition = require("noice").api.status.command.has,
        }

        local Mode = {
            {
                provider = require("noice").api.status.mode.get,
                hl = utils.get_highlight("Constant"),
            },
            LeftSeparator,
            condition = require("noice").api.status.mode.has,
        }

        local Ruler = {
            provider = "%-6.(%l:%c%V%)",
        }

        local ScrollBar = {
            static = {
                sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
            },
            provider = function(self)
                local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                local lines = vim.api.nvim_buf_line_count(0)
                local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                return string.rep(self.sbar[i], 2)
            end,
            hl = "Directory",
        }

        local StatusLine = {
            FileNameBlock,
            Space,
            Align,
            Commands,
            Mode,
            Ruler,
            Space,
            ScrollBar,
            hl = "StatusLine",
        }

        local StatusLineNC = {
            FileNameBlock,
            Space,
            Align,
            Ruler,
            Space,
            ScrollBar,
            hl = vim.tbl_extend("force", utils.get_highlight("StatusLineNC"), { force = true }),
            condition = conditions.is_not_active,
        }

        local StatusLines = {
            fallthrough = false,
            StatusLineNC,
            StatusLine,
        }

        require("heirline").setup({
            statusline = StatusLines,
        })
    end,
}

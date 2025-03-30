return {
    "rebelot/heirline.nvim",
    config = function()
        local conditions = require("heirline.conditions")
        local utils = require("heirline.utils")

        local function setup_colors()
            local diag_error = utils.get_highlight("DiagnosticError").fg
            local diag_hint = utils.get_highlight("DiagnosticHint").fg

            return {
                diag_error = diag_error,
                diag_hint = diag_hint,
                diag_info = utils.get_highlight("DiagnosticInfo").fg,
                diag_warn = utils.get_highlight("DiagnosticWarn").fg,
                red = diag_error,
                aqua = diag_hint,
            }
        end

        local Align = { provider = "%=" }
        local Space = { provider = " " }

        local FileNameBlock = {
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
                if vim.bo.filetype == "oil" then
                    self.filename = self.filename:gsub("oil://", "")
                end
            end,
            {
                init = function(self)
                    if vim.bo.filetype == "oil" then
                        self.icon, self.hl = require("mini.icons").get("directory", self.filename)
                        return
                    end
                    local icon, hl, is_default = require("mini.icons").get("file", self.filename)
                    if is_default or vim.bo.filetype == "help" then
                        icon, hl = require("mini.icons").get("filetype", vim.bo.filetype)
                    end
                    self.icon, self.hl = icon, hl
                end,
                provider = function(self)
                    return self.icon .. " "
                end,
            },
            {
                provider = function(self)
                    if self.filename == "" then
                        return "[Sin nombre]"
                    end

                    local filename = self.filename

                    if vim.bo.buftype == "help" then
                        return vim.fn.fnamemodify(filename, ":t")
                    end

                    if vim.bo.filetype == "oil" then
                        return vim.fn.fnamemodify(filename, ":~")
                    end

                    filename = vim.fn.fnamemodify(filename, ":~:.")

                    if Util.is_win then
                        filename = filename:gsub("\\", "/")
                    end

                    return filename
                end,
            },
            {
                condition = function()
                    return vim.bo.readonly
                end,
                provider = " 󰌾",
                hl = { fg = "red" },
            },
            {
                condition = function()
                    return vim.bo.modified
                end,
                provider = " ●",
            },
        }

        local Diagnostics = {
            condition = conditions.has_diagnostics,
            static = {
                error_icon = vim.diagnostic.config().signs.text["ERROR"],
                warn_icon = vim.diagnostic.config().signs.text["WARN"],
                info_icon = vim.diagnostic.config().signs.text["INFO"],
                hint_icon = vim.diagnostic.config().signs.text["HINT"],
            },
            init = function(self)
                self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            end,
            update = { "DiagnosticChanged", "BufEnter" },
            {
                provider = function(self)
                    return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ") or ""
                end,
                hl = { fg = "diag_error" },
            },
            {
                provider = function(self)
                    return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ") or ""
                end,
                hl = { fg = "diag_warn" },
            },
            {
                provider = function(self)
                    return self.info > 0 and (self.info_icon .. " " .. self.info .. " ") or ""
                end,
                hl = { fg = "diag_info" },
            },
            {
                provider = function(self)
                    return self.hints > 0 and (self.hint_icon .. " " .. self.hints .. " ") or ""
                end,
                hl = { fg = "diag_hint" },
            },
            Space,
        }

        local Ruler = {
            provider = "%-7.(%l:%c%V%) ",
        }

        local ScrollBar = {
            static = { sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" } },
            provider = function(self)
                local line = vim.api.nvim_win_get_cursor(0)[1]
                local total_lines = vim.api.nvim_buf_line_count(0)
                local i = math.ceil(line / total_lines * #self.sbar)
                return string.rep(self.sbar[i], 2)
            end,
            hl = { fg = "aqua" },
        }

        local StatusLine = {
            FileNameBlock,
            Align,
            Diagnostics,
            Ruler,
            ScrollBar,
            hl = function()
                if not conditions.is_active() then
                    return { fg = utils.get_highlight("StatusLineNC").fg, force = true }
                end
            end,
        }

        require("heirline").setup({
            statusline = StatusLine,
            opts = {
                colors = setup_colors(),
            },
        })

        vim.api.nvim_create_augroup("Heirline", { clear = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                utils.on_colorscheme(setup_colors())
            end,
            group = "Heirline",
        })
    end,
}

return {
    "rebelot/heirline.nvim",
    config = function()
        local function get_highlight(name)
            return vim.api.nvim_get_hl(0, { name = name })
        end

        local conditions = require("heirline.conditions")
        local Space = { provider = " " }
        local Align = { provider = "%=" }

        local lualine_ok = false
        local lualine_mode_opts = {}
        if vim.g.colors_name then
            lualine_ok, lualine_mode_opts = pcall(require, "lualine.themes." .. vim.g.colors_name)
        end

        if not lualine_ok then
            lualine_mode_opts = {
                normal = { a = { bg = "" } },
                visual = { a = { bg = "" } },
                terminal = { a = { bg = "" } },
                insert = { a = { bg = "" } },
                replace = { a = { bg = "" } },
                command = { a = { bg = "" } },
            }
        else
            vim.o.showmode = false
        end

        local ViMode = {
            condition = function()
                return lualine_ok
            end,
            init = function(self)
                self.mode = vim.fn.mode(1):sub(1, 1)
            end,
            static = {
                mode_hl_group = {
                    -- Normal
                    n = lualine_mode_opts.normal.a.bg,
                    -- Visual
                    v = lualine_mode_opts.visual.a.bg,
                    V = lualine_mode_opts.visual.a.bg,
                    ["\22"] = lualine_mode_opts.visual.a.bg,
                    -- Select
                    s = lualine_mode_opts.visual.a.bg,
                    S = lualine_mode_opts.visual.a.bg,
                    ["\19"] = lualine_mode_opts.visual.a.bg,
                    -- Insert
                    i = lualine_mode_opts.insert.a.bg,
                    -- Replace
                    R = lualine_mode_opts.replace.a.bg,
                    -- Command
                    c = lualine_mode_opts.command.a.bg,
                    -- Terminal
                    t = lualine_mode_opts.terminal and lualine_mode_opts.terminal.a.bg,
                },
            },
            provider = " ",
            hl = function(self)
                return { bg = self.mode_hl_group[self.mode] or lualine_mode_opts.normal.a.bg }
            end,
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },
        }

        local FileBlock = {
            init = function(self)
                self.filepath = vim.api.nvim_buf_get_name(0)
            end,
            {
                init = function(self)
                    self.icon, self.hl = MiniIcons.get("file", self.filepath)
                end,
                provider = function(self)
                    return self.icon .. " "
                end,
            },
            {
                provider = function(self)
                    if self.filepath == "" then
                        return vim.env.LANG  == "es_ES.UTF-8" and "[Sin nombre]" or "[No name]"
                    end

                    if vim.bo.filetype == "help" then
                        return vim.fn.fnamemodify(self.filepath, ":t")
                    end

                    local filepath = vim.fn.fnamemodify(self.filepath, ":."):gsub(vim.env.HOME, "~")

                    if not conditions.width_percent_below(#filepath, 0.40) then
                        filepath = vim.fn.pathshorten(filepath)
                    end

                    if vim.fn.has("win32") == 1 then
                        filepath = filepath:gsub("\\", "/")
                    end

                    return filepath
                end,
            },
            {
                condition = function()
                    return vim.bo.filetype == "help"
                end,
                init = function(self)
                    self.provider, self.hl = MiniIcons.get("filetype", "help")
                    self.provider = " " .. self.provider
                end,
            },
            {
                condition = function()
                    return vim.bo.readonly
                end,
                provider = " 󰌾",
                hl = "DiagnosticError",
            },
            {
                condition = function()
                    return vim.bo.modified
                end,
                provider = " ",
            },
            { provider = "%<" },
        }

        local Diagnostics = {
            condition = conditions.has_diagnostics,
            static = {
                error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR],
                warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN],
                info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO],
                hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT],
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
                    return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ")
                end,
                hl = "DiagnosticError",
            },
            {
                provider = function(self)
                    return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
                end,
                hl = "DiagnosticWarn",
            },
            {
                provider = function(self)
                    return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
                end,
                hl = "DiagnosticInfo",
            },
            {
                provider = function(self)
                    return self.hints > 0 and (self.hint_icon .. " " .. self.hints .. " ")
                end,
                hl = "DiagnosticHint",
            },
        }

        local Ruler = {
            provider = "%-8.(%l:%c%V%) %P",
        }

        local StatusLine = {
            condition = conditions.is_active,
            ViMode,
            Space,
            FileBlock,
            Align,
            Diagnostics,
            Space,
            Ruler,
            Space,
            ViMode,
        }

        local StatusLineNC = {
            hl = { fg = get_highlight("StatusLineNC").fg, force = true },
            Space,
            FileBlock,
            Align,
            Ruler,
            Space,
        }

        require("heirline").setup({
            statusline = {
                fallthrough = false,
                StatusLine,
                StatusLineNC,
            },
        })
    end,
}

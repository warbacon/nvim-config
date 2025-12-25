return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.statusline = " "
    end,
    config = function()
        local conditions = require("heirline.conditions")

        -- Helpers
        local function get_hl(name)
            return vim.api.nvim_get_hl(0, { name = name })
        end

        local Space = { provider = " " }
        local Align = { provider = "%=" }

        -- Load lualine theme once
        local lualine_ok, lualine_theme = pcall(require, "lualine.themes." .. (vim.g.colors_name or ""))
        if not lualine_ok then
            lualine_theme = {
                normal = { a = { bg = "" } },
                visual = { a = { bg = "" } },
                terminal = { a = { bg = "" } },
                insert = { a = { bg = "" } },
                replace = { a = { bg = "" } },
                command = { a = { bg = "" } },
            }
        else
            lualine_theme.terminal = lualine_theme.terminal or lualine_theme.insert
            vim.o.showmode = false
        end

        -- ViMode component
        local ViMode = {
            condition = function()
                return lualine_ok
            end,
            init = function(self)
                self.mode = vim.fn.mode(1):sub(1, 1)
            end,
            static = {
                mode_hl_group = {
                    n = lualine_theme.normal.a.bg,
                    v = lualine_theme.visual.a.bg,
                    V = lualine_theme.visual.a.bg,
                    ["\22"] = lualine_theme.visual.a.bg,
                    s = lualine_theme.visual.a.bg,
                    S = lualine_theme.visual.a.bg,
                    ["\19"] = lualine_theme.visual.a.bg,
                    i = lualine_theme.insert.a.bg,
                    R = lualine_theme.replace.a.bg,
                    c = lualine_theme.command.a.bg,
                    t = lualine_theme.terminal.a.bg,
                },
            },
            provider = " ",
            hl = function(self)
                return { bg = self.mode_hl_group[self.mode] or lualine_theme.normal.a.bg }
            end,
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },
        }

        -- FileBlock component
        local FileBlock = {
            init = function(self)
                local filepath = vim.api.nvim_buf_get_name(0)
                local is_win = vim.fn.has("win32") == 1

                -- Handle oil.nvim
                if vim.bo.filetype == "oil" and filepath:sub(1, 6) == "oil://" then
                    filepath = filepath:sub(7)
                    if filepath ~= "/" then
                        filepath = filepath:sub(1, -2)
                    end
                end

                self.filepath = filepath
                self.relative_filepath = vim.fn.fnamemodify(filepath, ":."):gsub(vim.env.HOME, "~")

                if is_win then
                    self.relative_filepath = self.relative_filepath:gsub("\\", "/")
                end
            end,

            -- File icon
            {
                init = function(self)
                    local ft = vim.bo.filetype
                    local is_dir = ft == "oil" or ft == "netrw"
                    self.icon, self.hl = MiniIcons.get(is_dir and "directory" or "file", self.filepath)
                end,
                provider = function(self)
                    return self.icon .. " "
                end,
            },

            -- Dirname
            {
                init = function(self)
                    local dirname = vim.fs.dirname(self.relative_filepath)

                    if dirname == "." or self.filepath == "/" then
                        self.dirname = ""
                        self.dirname_short = ""
                        return
                    end

                    if dirname == "/" then
                        self.dirname = "/"
                        self.dirname_short = "/"
                        return
                    end

                    self.dirname = dirname .. "/"

                    -- Extract protocol and path
                    local protocol = dirname:match("^(%w+://)")
                    local path = protocol and dirname:sub(#protocol + 1) or dirname

                    -- Split path into parts
                    local parts = vim.split(path, "/", { plain = true })

                    if #parts > 0 then
                        self.dirname_short = (protocol or "") .. "…/" .. parts[#parts] .. "/"
                    else
                        self.dirname_short = self.dirname
                    end
                end,
                provider = function(self)
                    if vim.bo.filetype == "help" or self.dirname == "" then
                        return ""
                    end

                    if not conditions.width_percent_below(#self.relative_filepath, 0.40) then
                        return self.dirname_short
                    end

                    return self.dirname
                end,
            },

            -- Filename
            {
                init = function(self)
                    if self.filepath == "/" then
                        self.filename = "/"
                    else
                        self.filename = self.filepath == "" and "%f" or vim.fs.basename(self.relative_filepath)
                    end
                end,
                provider = function(self)
                    return self.filename
                end,
                hl = function()
                    return vim.bo.modified and { fg = get_hl("CursorLineNr").fg, bold = true }
                        or { fg = get_hl("Normal").fg, bold = true }
                end,
            },

            -- Help hint
            {
                condition = function()
                    return vim.bo.filetype == "help"
                end,
                init = function(self)
                    self.provider, self.hl = MiniIcons.get("filetype", "help")
                    self.provider = " " .. self.provider
                end,
            },

            -- Readonly
            {
                condition = function()
                    return vim.bo.readonly
                end,
                provider = " 󰌾",
                hl = "DiagnosticError",
            },

            { provider = "%<" }, -- Trim
        }

        -- Diagnostics component
        local Diagnostics = {
            provider = function()
                return vim.diagnostic.status() .. " "
            end,
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
            vim.fn.has("nvim-0.12") == 1 and Diagnostics or {},
            Space,
            Ruler,
            Space,
            ViMode,
        }

        local StatusLineNC = {
            hl = { fg = get_hl("StatusLineNC").fg, force = true },
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

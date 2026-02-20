local M = {}

---@class pino.Config
---@field style? pino.Config.Style
---@field plugins? pino.Config.Plugins
---@field on_colors? fun(colors: table<string,string>)
---@field on_highlights? fun(highlights: table<string,vim.api.keyset.highlight>, colors: table<string,string>)

---@class pino.Config.Style
---@field italic? boolean
---@field bold? boolean
---@field undercurl? boolean

---@class pino.Config.Plugins
---@field blink_cmp? boolean
---@field lualine? boolean
---@field mason? boolean
---@field mini? boolean
---@field fzf_lua? boolean
---@field snacks? boolean

M.defaults = {
    style = {
        italic = true,
        bold = true,
        undercurl = true,
    },

    plugins = {
        blink_cmp = true,
        lualine = true,
        mason = true,
        mini = false,
        neogit = false,
        fzf_lua = false,
        snacks = false,
    },
    ---@diagnostic disable-next-line: unused-local
    on_colors = function(colors) end,
    ---@diagnostic disable-next-line: unused-local
    on_highlights = function(highlights, colors) end,
}

---@class pino.Config
M.options = nil

---@param opts? pino.Config
M.setup = function(opts)
    M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

setmetatable(M, {
    __index = function(_, k)
        if k == "options" then
            return M.defaults
        end
    end,
})

return M

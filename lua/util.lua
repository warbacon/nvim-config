local M = {}

---@type boolean
M.is_nixos = vim.uv.fs_stat("/etc/NIXOS") ~= nil

---@class Icons
---@field indent string
---@field diagnostic table<string, string>
---@field kinds table<string, string>

---@type Icons
M.icons = {
    indent = "│",
    diagnostic = {
        Error = "",
        Warn = "",
        Info = "",
        Hint = "",
    },
    kinds = {
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Keyword = "",
        Method = "",
        Module = "",
        Operator = "",
        Property = "",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "",
    },
}

return M

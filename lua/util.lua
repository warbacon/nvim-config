local M = {}

M.is_win = vim.uv.os_uname().sysname:find("Windows") ~= nil
M.is_lin = vim.uv.os_uname().sysname:find("Linux") ~= nil

M.icons = {
    diagnostics = {
        ERROR = "",
        HINT = "",
        INFO = "",
        WARN = "",
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

local M = {}

---@class Icons
---@field indent string
---@field signs string[]
---@field kinds table<string, string>

---@type Icons
M.icons = {
    indent = "▏",
    signs = { "", "", "", "" },
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

M.treesitter = {}
M.treesitter._installed = nil ---@type table<string,string>?
function M.treesitter.get_installed()
    if not M.treesitter._installed then
        M.treesitter._installed = {}
        for _, lang in ipairs(require("nvim-treesitter").get_installed()) do
            M.treesitter._installed[lang] = lang
        end
    end

    return M.treesitter._installed
end

return M

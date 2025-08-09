local M = {}

vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    callback = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
    end,
})

---@param func function
function M.later(func)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
            vim.schedule(func)
        end,
    })
end

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

return M

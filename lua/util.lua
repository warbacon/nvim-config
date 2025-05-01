local M = {}

M.is_win = vim.uv.os_uname().sysname:find("Windows") ~= nil
M.is_lin = vim.uv.os_uname().sysname:find("Linux") ~= nil

M.icons = {
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

---@type table<string, table>
M.lsp_servers = (function()
    local servers = {}
    local lsp_path = vim.fn.stdpath("config") .. "/lua/lsp"

    local fd = vim.uv.fs_scandir(lsp_path)
    if not fd then
        return servers
    end

    while true do
        local name, t = vim.uv.fs_scandir_next(fd)
        if not name then
            break
        end
        if t == "file" and name:match("%.lua$") then
            local server = name:gsub("%.lua$", "")
            local ok, config = pcall(require, "lsp." .. server)
            if ok and type(config) == "table" then
                servers[server] = config
            else
                vim.notify("Error loading LSP config for: " .. server, vim.log.levels.ERROR)
            end
        end
    end

    return servers
end)()

return M

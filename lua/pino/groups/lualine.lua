local M = {}

---@return table<string,vim.api.keyset.highlight>
M.get = function()
    return {
        LualineDiffAdd = { link = "Added" },
        LualineDiffChange = { link = "Changed" },
        LualineDiffDelete = { link = "Removed" },
    }
end

return M

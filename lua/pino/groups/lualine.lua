local M = {}

---@param colors table<string,string>
---@param config pino.Config
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors, config)
    return {
        LualineDiffAdd = { link = "Added" },
        LualineDiffChange = { link = "Changed" },
        LualineDiffDelete = { link = "Removed" },
    }
end

return M

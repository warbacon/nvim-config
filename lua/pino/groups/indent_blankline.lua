local M = {}

---@param colors table<string,string>
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors)
    return {
        IblWhiteSpace = { fg = colors.highlight },
        IblScope = { fg = colors.pine },
    }
end

return M

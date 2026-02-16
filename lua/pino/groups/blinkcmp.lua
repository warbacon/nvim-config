local M = {}

---@param colors table<string,string>
---@param config pino.Config
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors, config)
    return {
        BlinkCmpMenuBorder = { link = "PmenuBorder" },
        BlinkCmpKindConstant = { link = "Constant" },
        BlinkCmpKindConstructor = { link = "Function" },
        BlinkCmpKindFolder = { link = "Directory" },
        BlinkCmpKindFunction = { link = "Function" },
        BlinkCmpKindKeyword = { fg = colors.rose },
        BlinkCmpKindProperty = { link = "Identifier" },
        BlinkCmpKindEnum = { link = "Identifier" },
        BlinkCmpKindField = { link = "Identifier" },
    }
end

return M

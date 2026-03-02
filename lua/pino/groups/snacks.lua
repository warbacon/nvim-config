local M = {}

---@param colors table<string,string>
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors)
    local util = require("pino.util")

    return {
        SnacksPickerCursorline = { bg = util.blend(colors.pine, 0.3, colors.surface) },
        SnacksPickerMatch = { fg = colors.love },
        SnacksPickerPrompt = { fg = colors.rose },
        SnacksTitle = { fg = colors.rose, bg = colors.surface, bold = true },
        SnacksIndentScope = { fg = colors.pine },
        SnacksIndent = { fg = colors.highlight },
    }
end

return M

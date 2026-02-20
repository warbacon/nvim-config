local M = {}

---@param colors table<string,string>
---@param config pino.Config
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors, config)
    local util = require("pino.util")

    return {
        SnacksPickerCursorline = { bg = util.blend(colors.pine, 0.2, colors.surface) },
        SnacksPickerMatch = { fg = colors.love },
        SnacksPickerPrompt = { fg = colors.rose },
        SnacksTitle = { fg = colors.rose, bg = colors.surface, bold = true },
    }
end

return M

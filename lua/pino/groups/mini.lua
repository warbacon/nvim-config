local M = {}

---@param colors table<string,string>
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors)
    local util = require("pino.util")

    return {
        MiniPickMatchCurrent = { link = "PmenuSel" },
        MiniPickMatchMarked = { bg = util.blend(colors.pine, 0.3, colors.surface) },
        MiniPickMatchRanges = { fg = colors.love },
        MiniPickPrompt = { fg = "none", bg = colors.surface },
        MiniPickPromptCaret = { fg = colors.rose, bg = colors.surface },
        MiniPickPromptPrefix = { fg = colors.rose, bg = colors.surface },
    }
end

return M

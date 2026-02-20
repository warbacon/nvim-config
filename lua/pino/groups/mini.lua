local M = {}

---@param colors table<string,string>
---@param config pino.Config
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors, config)
    local util = require("pino.util")

    return {
        MiniPickMatchCurrent = { bg = colors.overlay },
        MiniPickMatchMarked = { bg = util.blend(colors.pine, 0.2, colors.surface) },
        MiniPickMatchRanges = { fg = colors.love },
        MiniPickPrompt = { fg = "none", bg = colors.surface },
        MiniPickPromptCaret = { fg = colors.rose, bg = colors.surface },
        MiniPickPromptPrefix = { fg = colors.rose, bg = colors.surface },
    }
end

return M

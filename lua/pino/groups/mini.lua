local M = {}

---@param colors table<string,string>
---@param config pino.Config
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors, config)
    return {
        MiniPickMatchCurrent = { bg = colors.overlay },
        MiniPickMatchMarked = { bg = colors.highlight },
        MiniPickMatchRanges = { fg = colors.mango },
        MiniPickPrompt = { fg = "none", bg = colors.surface },
        MiniPickPromptCaret = { fg = colors.mango, bg = colors.surface },
        MiniPickPromptPrefix = { fg = colors.mango, bg = colors.surface },
    }
end

return M

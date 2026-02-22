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
        MiniStatuslineModeNormal = { fg = colors.surface, bg = colors.pine },
        MiniStatuslineModeInsert = { fg = colors.surface, bg = colors.leaf },
        MiniStatuslineModeVisual = { fg = colors.surface, bg = colors.iris },
        MiniStatuslineModeReplace = { fg = colors.surface, bg = colors.love },
        MiniStatuslineModeCommand = { fg = colors.surface, bg = colors.gold },
        MiniStatuslineModeOther = { fg = colors.surface, bg = colors.leaf },
        MiniStatuslineDevinfo = { fg = colors.subtle, bg = colors.highlight },
        MiniStatuslineFileinfo = { fg = colors.subtle, bg = colors.highlight },
        MiniStatuslineFilename = { fg = colors.subtle },
    }
end

return M

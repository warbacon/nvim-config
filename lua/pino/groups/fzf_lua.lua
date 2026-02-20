local M = {}

---@param colors table<string,string>
---@param config pino.Config
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors, config)
    return {
        FzfLuaNormal = { fg = colors.text, bg = colors.base },
        FzfLuaBorder = { fg = colors.pine, bg = colors.base },
        FzfLuaTitle = { fg = colors.rose, bold = true },
        FzfLuaPreviewTitle = { fg = colors.pine },
        FzfLuaTitleFlags = { fg = colors.base, bg = colors.rose },
        FzfLuaFzfCursorLine = { link = "Visual" },
        FzfLuaFzfMatch = { fg = colors.love },
        FzfLuaFzfPointer = { fg = colors.rose },
        FzfLuaFzfPrompt = { fg = colors.rose },
        FzfLuaFzfScrollbar = { fg = colors.rose },
        FzfLuaScrollBorderEmpty = { link = "FzfLuaFzfScrollbar" },
        FzfLuaScrollBorderFull = { link = "FzfLuaFzfScrollbar" },
        FzfLuaHeaderBind = { link = "@punctuation.special" },
        FzfLuaHeaderText = { link = "Title" },
    }
end

return M

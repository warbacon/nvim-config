local M = {}

---@param colors table<string,string>
---@param config pino.Config
---@return table<string,vim.api.keyset.highlight>
M.get = function(colors, config)
    return {
        MasonHeader = { fg = colors.surface, bg = colors.mango, bold = true },
        MasonHeaderSecondary = { fg = colors.surface, bg = colors.pine, bold = true },
        MasonHighlight = { fg = colors.pine },
        MasonHighlightBlock = { bg = colors.pine, fg = colors.surface },
        MasonHighlightBlockBold = { bg = colors.pine, fg = colors.surface, bold = true },
        MasonHighlightBlockSecondary = { bg = colors.mango, fg = colors.surface },
        MasonHighlightBlockSecondaryBold = { bg = colors.mango, fg = colors.surface, bold = true },
        MasonHighlightSecondary = { fg = colors.mango, default = true },
        MasonMuted = { fg = colors.subtle },
        MasonMutedBlock = { bg = colors.highlight },
        MasonMutedBlockBold = { bg = colors.highlight, bold = true },
    }
end

return M

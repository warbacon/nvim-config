local palette = require("clearpine.palette")

return {
    -- UI
    Normal = { fg = palette.text, bg = palette.base },
    StatusLine = { fg = palette.subtle, bg = palette.surface },
    StatusLineNC = { fg = palette.muted, bg = palette.surface },
    NonText = { fg = palette.muted },
    LineNr = { fg = palette.muted },
    Visual = { bg = palette.overlay },
    WinSeparator = { fg = palette.highlight },
    ColorColumn = { bg = palette.overlay },

    -- Syntax
    Comment = { fg = palette.muted, italic = true },
    Constant = { fg = palette.mango },
    Delimiter = { fg = palette.subtle },
    Directory = { fg = palette.pine },
    Function = { fg = palette.pine },
    Title = { fg = palette.pine, bold = true },
    Identifier = { fg = palette.foam },
    Operator = { fg = palette.subtle },
    PreProc = { italic = true },
    Special = { fg = palette.iris },
    Quote = { fg = palette.subtle },
    Statement = { fg = palette.subtle, italic = true },
    String = { fg = palette.gold },
    Type = { fg = "none" },

    -- Language
    htmlArg = { fg = palette.foam },
    htmlTagName = { fg = palette.love, bold = true },
    markdownCode = { bg = palette.surface },

    -- Messages
    ErrorMsg = { fg = palette.love },
    OkMsg = { fg = palette.leaf },
    WarningMsg = { fg = palette.mango },

    -- TreeSitter
    ["@variable"] = { fg = "none" },
    ["@variable.builtin"] = { fg = palette.love, bold = true },
    ["@punctuation"] = { link = "Delimiter" },
    ["@punctuation.special"] = { link = "Delimiter" },
    ["@variable.member"] = { fg = palette.rose },
    ["@markup.quote.markdown"] = { fg = palette.subtle },
    ["@tag"] = { fg = palette.love, bold = true },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@tag.attribute"] = { fg = palette.foam },
    ["@markup.raw"] = { bg = palette.surface },
    ["@markup.raw.block"] = { bg = "none" },
}

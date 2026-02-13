if vim.g.colors_name then
    vim.cmd("hi clear")
end

vim.g.colors_name = "oldpino"

---@type table<string, string>
local palette = {
    cave = "#0E0D14",
    base = "#191724",
    surface = "#252235",
    overlay = "#312D47",
    highlight = "#4a4667",
    muted = "#585476",
    subtle = "#928eb4",
    text = "#d1cfe9",

    love = "#eb6f92",
    rose = "#ebbcba",
    dawn = "#ffb58d",
    gold = "#f6c177",
    leaf = "#94c68d",
    foam = "#9ccfd8",
    pine = "#3a94b7",
    iris = "#c4a7e7",

    none = "NONE",
}

---@type table<string, vim.api.keyset.highlight>
local colors = {
    -- UI: Base and Editor
    ColorColumn = { bg = palette.surface },
    CursorLine = { bg = palette.surface },
    CursorLineNr = { fg = palette.gold, bold = true },
    LineNr = { fg = palette.muted },
    MatchParen = { bg = palette.highlight, bold = true },
    NonText = { fg = palette.muted },
    Normal = { fg = palette.text, bg = palette.base },
    Visual = { bg = palette.overlay },
    WinSeparator = { fg = palette.highlight },

    -- UI: Float, Menus and StatusLine
    Pmenu = { bg = palette.surface },
    PmenuExtra = { fg = palette.subtle },
    PmenuBorder = { fg = palette.pine, bg = palette.surface },
    PmenuKind = { fg = palette.subtle },
    PmenuSbar = { bg = palette.overlay },
    PmenuSel = { bg = palette.overlay },
    PmenuThumb = { bg = palette.muted },
    NormalFloat = { bg = palette.surface },
    FloatBorder = { fg = palette.pine, bg = palette.surface },
    FloatTitle = { bg = palette.surface },
    StatusLine = { fg = palette.subtle, bg = palette.surface },
    StatusLineNC = { fg = palette.muted, bg = palette.surface },

    -- Syntax: General
    Added = { fg = palette.leaf },
    Boolean = { fg = palette.rose },
    Changed = { fg = palette.foam },
    Comment = { fg = palette.muted, italic = true },
    Conceal = { fg = palette.subtle },
    Constant = { fg = palette.gold },
    Delimiter = { fg = palette.subtle },
    Directory = { fg = palette.pine },
    Folded = { bg = palette.surface },
    Function = { fg = palette.rose },
    Identifier = { fg = palette.foam },
    Operator = { link = "Delimiter" },
    Removed = { fg = palette.love },
    Special = { fg = palette.subtle },
    Statement = { fg = palette.subtle, italic = true },
    String = { fg = palette.gold },
    Tag = { fg = palette.love, bold = true },
    Title = { fg = palette.pine, bold = true },
    Type = { italic = true, bold = true },

    -- Syntax: Treesitter / Semantic
    ["@function.builtin"] = { link = "Function" },
    ["@lsp.type.type"] = { link = "Type" },
    ["@lsp.typemod.variable.readonly"] = { link = "Constant" },
    ["@markup.heading.1.markdown"] = { fg = palette.pine, bold = true },
    ["@markup.heading.2.markdown"] = { fg = palette.gold, bold = true },
    ["@markup.heading.3.markdown"] = { fg = palette.leaf, bold = true },
    ["@markup.heading.4.markdown"] = { fg = palette.foam, bold = true },
    ["@markup.heading.5.markdown"] = { fg = palette.iris, bold = true },
    ["@markup.heading.6.markdown"] = { fg = palette.iris, bold = true },
    ["@markup.link"] = { fg = palette.iris },
    ["@markup.link.label"] = { fg = palette.foam },
    ["@markup.link.url"] = { fg = palette.iris, sp = palette.iris, underline = true },
    ["@markup.list.checked.markdown"] = { fg = palette.pine, bold = true },
    ["@markup.raw"] = { bg = palette.overlay },
    ["@markup.raw.block"] = { bg = palette.none },
    ["@string.special"] = { link = "String" },
    ["@string.special.url"] = { link = "@markup.link.url" },
    ["@tag.attribute"] = { fg = palette.foam },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@type.builtin"] = { link = "Type" },
    ["@variable"] = { link = "Normal" },
    ["@variable.builtin"] = { fg = palette.love, bold = true },
    ["@variable.member"] = { fg = palette.foam },

    -- Diagnostics
    DiagnosticInfo = { fg = palette.foam },
    DiagnosticHint = { fg = palette.pine },
    DiagnosticWarn = { fg = palette.gold },
    DiagnosticError = { fg = palette.love },
    DiagnosticFloatingInfo = { bg = palette.surface },

    -- Diagnostic Underlines
    DiagnosticUnderlineInfo = { sp = palette.foam, undercurl = true },
    DiagnosticUnderlineHint = { sp = palette.pine, undercurl = true },
    DiagnosticUnderlineWarn = { sp = palette.gold, undercurl = true },
    DiagnosticUnderlineError = { sp = palette.love, undercurl = true },

    -- Messages
    ErrorMsg = { fg = palette.love },
    ModeMsg = { fg = palette.gold, bold = true },
    MoreMsg = { fg = palette.pine },
    OkMsg = { fg = palette.leaf },
    Question = { fg = palette.pine },
    WarningMsg = { fg = palette.gold },

    -- Mini Icons
    MiniIconsAzure = { fg = palette.pine },
    MiniIconsBlue = { fg = palette.pine },
    MiniIconsCyan = { fg = palette.foam },
    MiniIconsGreen = { fg = palette.leaf },
    MiniIconsGray = { fg = palette.muted },
    MiniIconsOrange = { fg = palette.rose },
    MiniIconsPurple = { fg = palette.iris },
    MiniIconsRed = { fg = palette.love },
    MiniIconsYellow = { fg = palette.gold },

    -- Mini Pick
    MiniPickMatchCurrent = { bg = palette.overlay },

    -- Blink.cmp
    BlinkCmpKindConstant = { link = "Constant" },
    BlinkCmpKindConstructor = { link = "Function" },
    BlinkCmpKindEnum = { fg = palette.gold },
    BlinkCmpKindField = { fg = palette.foam },
    BlinkCmpKindFolder = { link = "Directory" },
    BlinkCmpKindFunction = { link = "Function" },
    BlinkCmpKindMethod = { link = "Function" },
    BlinkCmpKindProperty = { fg = palette.foam },
    BlinkCmpKindStruct = { fg = palette.foam },
    BlinkCmpMenuBorder = { link = "PmenuBorder" },
}

for group, hl in pairs(colors) do
    vim.api.nvim_set_hl(0, group, hl)
end

vim.g.terminal_color_0 = palette.overlay -- Black
vim.g.terminal_color_1 = palette.love -- Red
vim.g.terminal_color_2 = palette.leaf -- Green
vim.g.terminal_color_3 = palette.gold -- Yellow
vim.g.terminal_color_4 = palette.pine -- Blue
vim.g.terminal_color_5 = palette.iris -- Magenta
vim.g.terminal_color_6 = palette.foam -- Cyan
vim.g.terminal_color_7 = palette.subtle -- White

vim.g.terminal_color_8 = palette.muted -- Bright Black
vim.g.terminal_color_9 = palette.love -- Bright Red
vim.g.terminal_color_10 = palette.leaf -- Bright Green
vim.g.terminal_color_11 = palette.gold -- Bright Yellow
vim.g.terminal_color_12 = palette.pine -- Bright Blue
vim.g.terminal_color_13 = palette.iris -- Bright Magenta
vim.g.terminal_color_14 = palette.foam -- Bright Cyan
vim.g.terminal_color_15 = palette.text -- Bright White

if vim.g.colors_name then
    vim.cmd("hi clear")
end

vim.g.colors_name = "pino"

---@type table<string, string>
local palette = {
    _nc = "#16141f",
    base = "#191724",
    surface = "#1f1d2e",
    overlay = "#26233a",
    muted = "#6e6a86",
    subtle = "#908caa",
    text = "#e0def4",
    love = "#eb6f92",
    gold = "#f6c177",
    rose = "#ebbcba",
    pine = "#89b4fa",
    foam = "#9ccfd8",
    iris = "#c4a7e7",
    leaf = "#95b1ac",
    highlight_low = "#21202e",
    highlight_med = "#403d52",
    highlight_high = "#524f67",
    none = "NONE",
}

---@type table<string, vim.api.keyset.highlight>
local colors = {
    -- UI: Base and Editor
    Normal = { fg = palette.text, bg = palette.base },
    Visual = { bg = palette.highlight_med },
    CursorLine = { bg = palette.overlay },
    LineNr = { fg = palette.muted },
    CursorLineNr = { fg = palette.gold, bold = true },
    NonText = { fg = palette.muted },
    ColorColumn = { bg = palette.surface },
    WinSeparator = { fg = palette.highlight_med },
    MatchParen = { bg = palette.highlight_med, bold = true },

    -- UI: Float, Menus and StatusLine
    Pmenu = { bg = palette.surface },
    PmenuExtra = { fg = palette.subtle, bg = palette.surface },
    PmenuBorder = { fg = palette.foam, bg = palette.surface },
    PmenuKind = { fg = palette.subtle },
    PmenuSbar = { bg = palette.overlay },
    PmenuSel = { bg = palette.overlay },
    PmenuThumb = { bg = palette.muted },
    NormalFloat = { bg = palette.surface },
    FloatBorder = { fg = palette.foam, bg = palette.surface },
    FloatTitle = { bg = palette.surface },
    StatusLine = { fg = palette.subtle, bg = palette.surface },
    StatusLineNC = { fg = palette.muted, bg = palette.surface },

    -- Syntax: General
    Added = { fg = palette.leaf },
    Boolean = { fg = palette.rose },
    Changed = { fg = palette.foam },
    Comment = { fg = palette.muted, italic = true },
    Constant = { fg = palette.gold },
    Delimiter = { fg = palette.subtle },
    Directory = { fg = palette.pine },
    Function = { fg = palette.rose },
    Identifier = { fg = palette.foam },
    Removed = { fg = palette.love },
    Special = { fg = palette.subtle },
    Statement = { fg = palette.subtle, italic = true },
    String = { fg = palette.gold },
    Title = { fg = palette.pine, bold = true },
    Type = { italic = true },
    Conceal = { fg = palette.subtle },
    Tag = { fg = palette.love, bold = true },

    -- Syntax: Treesitter / Semantic
    ["@markup.heading.1.markdown"] = { fg = palette.blue, bold = true },
    ["@markup.heading.2.markdown"] = { fg = palette.gold, bold = true },
    ["@markup.heading.3.markdown"] = { fg = palette.leaf, bold = true },
    ["@markup.heading.4.markdown"] = { fg = palette.foam, bold = true },
    ["@markup.heading.5.markdown"] = { fg = palette.iris, bold = true },
    ["@markup.heading.6.markdown"] = { fg = palette.iris, bold = true },
    ["@markup.link"] = { underline = false },
    ["@markup.link.label"] = { fg = palette.foam },
    ["@markup.heading.gitcommit"] = { fg = palette.text, bold = true },
    ["@markup.link.url"] = { fg = palette.iris, sp = palette.iris, underline = true },
    ["@string.special.url"] = { link = "@markup.link.url" },
    ["@string.special.path"] = { fg = palette.pine, underline = true },
    ["@markup.raw"] = { bg = palette.overlay },
    ["@markup.raw.block"] = { fg = palette.subtle, bg = palette.none },
    ["@tag.attribute"] = { fg = palette.foam },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@function.builtin"] = { link = "Function" },
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
    ModeMsg = { fg = palette.gold, bold = true },
    ErrorMsg = { fg = palette.love },
    OkMsg = { fg = palette.leaf },
    WarningMsg = { fg = palette.gold },
    MoreMsg = { fg = palette.pine },
    Question = { fg = palette.pine },

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

    -- Blink.cmp
    BlinkCmpKindMethod = { fg = palette.iris },
    BlinkCmpKindFunction = { fg = palette.rose },
    BlinkCmpKindConstructor = { fg = palette.rose },
    BlinkCmpKindField = { fg = palette.foam },
    BlinkCmpKindVariable = { fg = palette.pine },
    BlinkCmpKindClass = { fg = palette.gold },
    BlinkCmpKindInterface = { fg = palette.gold },
    BlinkCmpKindModule = { fg = palette.foam },
    BlinkCmpKindProperty = { fg = palette.foam },
    BlinkCmpKindValue = { fg = palette.gold },
    BlinkCmpKindEnum = { fg = palette.gold },
    BlinkCmpKindKeyword = { fg = palette.iris },
    BlinkCmpKindColor = { fg = palette.leaf },
    BlinkCmpKindFolder = { link = "Directory" },
    BlinkCmpKindEnumMember = { fg = palette.foam },
    BlinkCmpKindConstant = { fg = palette.gold },
    BlinkCmpKindStruct = { fg = palette.gold },
    BlinkCmpKindEvent = { fg = palette.leaf },
    BlinkCmpKindTypeParameter = { fg = palette.iris },
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

if vim.g.colors_name then
    vim.cmd("hi clear")
end

vim.g.colors_name = "pino"

---@type table<string,vim.api.keyset.highlight>
local colors = {
    Normal = { fg = "#e0def4", bg = "#191724" },
    CursorLine = { bg = "#21202e" },
    StatusLine = { bg = "#1f1d2e" },
    StatusLineNC = { fg = "#908caa", bg = "#1f1d2e" },
    LineNr = { fg = "#6e6a86" },
    SignColumn = { fg = "#6e6a86" },
    CursorLineNr = { fg = "#f6c177", bold = true },
    Pmenu = { bg = "#26233a" },
    PmenuBorder = { fg = "#9ccfd8", bg = "#26233a" },
    NormalFloat = { bg = "#26233a" },
    FloatBorder = { fg = "#9ccfd8", bg = "#26233a" },
    FloatTitle = { bg = "#26233a" },
    DiagnosticFloatingInfo = { bg = "#26233a" },
    Visual = { bg = "#403d52" },
    MatchParen = { bg = "#403d52", bold = true },
    String = { fg = "#f6c177" },
    Identifier = { fg = "#9ccfd8" },
    Special = { fg = "#908caa" },
    Statement = { fg = "#908caa", italic = true },
    Type = { italic = true },
    Delimiter = { fg = "#908caa" },
    Constant = { fg = "#f6c177" },
    Function = { fg = "#ebbcba" },
    Comment = { fg = "#6e6a86" },
    Directory = { fg = "#58ace4" },
    ModeMsg = { fg = "#f6c177" },
    ErrorMsg = { fg = "#eb6f92" },
    DiagnosticInfo = { fg = "#9ccfd8" },
    DiagnosticHint = { fg = "#58ace4" },
    DiagnosticError = { fg = "#eb6f92" },
    DiagnosticWarn = { fg = "#f6c177" },
    DiagnosticUnderlineInfo = { sp = "#9ccfd8", undercurl = true },
    DiagnosticUnderlineHint = { sp = "#58ace4", undercurl = true },
    DiagnosticUnderlineError = { sp = "#eb6f92", undercurl = true },
    DiagnosticUnderlineWarn = { sp = "#f6c177", undercurl = true },
    ColorColumn = { bg = "#1f1d2e" },
    ["@markup.raw.markdown_inline"] = { bg = "#403d52" },
    ["@tag.attribute.html"] = { fg = "#9ccfd8" },
    ["@markup.link.url"] = { fg = "#c4a7e7" },
    ["@markup.link.label"] = { sp = "#c4a7e7", bold = true, underline = true },
    ["@markup.link"] = { sp = "#c4a7e7", underline = true },
    MiniIconsAzure = { fg = "#58ace4" },
    MiniIconsBlue = { fg = "#58ace4" },
    MiniIconsCyan = { fg = "#9ccfd8" },
    MiniIconsGreen = { fg = "#68BD92" },
    MiniIconsGray = { fg = "#6e6a86" },
    MiniIconsOrange = { fg = "#ebbcba" },
    MiniIconsPurple = { fg = "#c4a7e7" },
    MiniIconsRed = { fg = "#eb6f92" },
    MiniIconsYellow = { fg = "#f6c177" },
    MiniPickMatchCurrent = { link = "Visual" },
}

for group, hl in pairs(colors) do
    vim.api.nvim_set_hl(0, group, hl)
end

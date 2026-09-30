vim.o.background = "dark"
vim.o.termguicolors = true

if vim.g.colors_name then
	vim.cmd("hi clear")
end
vim.g.colors = "lignite"

---@type table<string,string>
local palette = {
	fg1 = "#ebdbb2",
	fg4 = "#a89984",
	gray = "#928374",
	bg0 = "#1c1c1c",
	bg1 = "#282828",
	bg2 = "#3c3836",
	bg3 = "#504945",
	bg5 = "#7c6f64",

	purple_dark = "#b16286",
	blue_dark = "#458588",
	aqua_dark = "#689d6a",
	green_dark = "#98971a",
	yellow_dark = "#d79921",
	orange_dark = "#d65d0e",
	red_dark = "#cc241d",

	purple = "#d3869b",
	blue = "#83a598",
	aqua = "#8ec07c",
	green = "#b8bb26",
	yellow = "#fabd2f",
	orange = "#fe8019",
	red = "#fb4934",
}

---@type table<string,vim.api.keyset.highlight>
local highlights = {
	Normal = { fg = palette.fg1, bg = palette.bg0 },
	Statusline = { bg = palette.bg3 },
	StatuslineNC = { fg = palette.fg4, bg = palette.bg3 },
	CursorLineNr = { fg = palette.yellow, bold = true },
	LineNr = { fg = palette.bg5 },
	Visual = { bg = palette.bg2 },
	ModeMsg = { fg = palette.yellow, bold = true },
	ColorColumn = { bg = palette.bg2 },
	CursorLine = { bg = palette.bg1 },
	MatchParen = { bg = palette.bg3, bold = true },
	SignColumn = { link = "LineNr" },
	QuickFixLine = { fg = palette.orange, bold = true },
	WinSeparator = { fg = palette.bg2 },
	Folded = { fg = palette.fg1, bg = palette.bg1 },

	Pmenu = { bg = palette.bg2 },
	PmenuSel = { bg = palette.bg3 },
	PmenuThumb = { bg = palette.bg5 },
	PmenuKind = { fg = palette.red },
	PmenuExtra = { fg = palette.gray },
	PmenuBorder = { fg = palette.gray },

	NormalFloat = { bg = palette.bg1 },
	FloatBorder = { fg = palette.gray },

	Added = { fg = palette.green },
	Changed = { fg = palette.blue },
	Removed = { fg = palette.red },
	DiffDelete = { fg = palette.red, bold = true },

	Error = { fg = palette.red, bold = true },
	Todo = { fg = palette.blue },

	MoreMsg = { fg = palette.blue },
	ErrorMsg = { fg = palette.red },
	OkMsg = { fg = palette.green },
	Question = { fg = palette.aqua },
	DiagnosticError = { fg = palette.red },
	DiagnosticWarn = { fg = palette.yellow },
	DiagnosticOk = { fg = palette.green },
	DiagnosticHint = { fg = palette.blue },
	DiagnosticInfo = { fg = palette.aqua },
	DiagnosticUnderlineError = { sp = palette.red, undercurl = true },
	DiagnosticUnderlineWarn = { sp = palette.yellow, undercurl = true },
	DiagnosticUnderlineOk = { sp = palette.green, undercurl = true },
	DiagnosticUnderlineHint = { sp = palette.blue, undercurl = true },
	DiagnosticUnderlineInfo = { sp = palette.aqua, undercurl = true },

	SpellBad = { link = "DiagnosticUnderlineError" },
	SpellCap = { link = "DiagnosticUnderlineWarn" },
	SpellRare = { link = "DiagnosticUnderlineHint" },
	SpellLocal = { link = "DiagnosticUnderlineInfo" },

	Identifier = { fg = palette.blue },
	PreProc = { fg = palette.aqua },
	Directory = { fg = palette.blue, bold = true },
	Statement = { fg = palette.red },
	String = { fg = palette.green },
	Function = { fg = palette.green, bold = true },
	Delimiter = { fg = palette.orange },
	Special = { fg = palette.orange },
	Operator = { fg = palette.aqua },
	Structure = { fg = palette.aqua },
	Comment = { fg = palette.gray, italic = true },
	Conceal = { link = "NonText" },
	NonText = { fg = palette.gray },
	Type = { fg = palette.yellow },
	Constant = { fg = palette.purple },
	Title = { fg = palette.green, bold = true },

	["@variable"] = { fg = palette.fg1 },
	["@markup.quote"] = { link = "Comment" },
	["@tag.attribute"] = { link = "Identifier" },
	["@lsp.type.delimiter"] = { link = "Delimiter" },

	["@markup.heading.1"] = { fg = palette.green, bold = true },
	["@markup.heading.2"] = { fg = palette.yellow, bold = true },
	["@markup.heading.3"] = { fg = palette.purple, bold = true },
	["@markup.heading.4"] = { fg = palette.blue, bold = true },
	["@markup.heading.5"] = { fg = palette.aqua, bold = true },
	["@markup.heading.6"] = { fg = palette.aqua, bold = true },

	RenderMarkdownH1Bg = { fg = palette.bg0, bg = palette.green, bold = true },
	RenderMarkdownH2Bg = { fg = palette.bg0, bg = palette.yellow, bold = true },
	RenderMarkdownH3Bg = { fg = palette.bg0, bg = palette.purple, bold = true },
	RenderMarkdownH4Bg = { fg = palette.bg0, bg = palette.blue, bold = true },
	RenderMarkdownH5Bg = { fg = palette.bg0, bg = palette.aqua, bold = true },
	RenderMarkdownH6Bg = { fg = palette.bg0, bg = palette.aqua, bold = true },

	MiniIconsAzure = { fg = palette.blue },
	MiniIconsBlue = { fg = palette.blue },
	MiniIconsCyan = { fg = palette.aqua },
	MiniIconsGreen = { fg = palette.green },
	MiniIconsGrey = { fg = palette.gray },
	MiniIconsOrange = { fg = palette.orange },
	MiniIconsPurple = { fg = palette.purple },
	MiniIconsRed = { fg = palette.red },
	MiniIconsYellow = { fg = palette.yellow },
}

for group, hl in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, hl)
end

vim.g.terminal_color_0 = palette.bg0
vim.g.terminal_color_1 = palette.red_dark
vim.g.terminal_color_2 = palette.green_dark
vim.g.terminal_color_3 = palette.yellow_dark
vim.g.terminal_color_4 = palette.blue_dark
vim.g.terminal_color_5 = palette.purple_dark
vim.g.terminal_color_6 = palette.aqua_dark
vim.g.terminal_color_7 = palette.fg4
vim.g.terminal_color_8 = palette.gray
vim.g.terminal_color_9 = palette.red
vim.g.terminal_color_10 = palette.green
vim.g.terminal_color_11 = palette.yellow
vim.g.terminal_color_12 = palette.blue
vim.g.terminal_color_13 = palette.purple
vim.g.terminal_color_14 = palette.aqua
vim.g.terminal_color_15 = palette.fg1

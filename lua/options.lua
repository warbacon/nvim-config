-- Set global leader key
vim.g.mapleader = " "

-- Print the relative line number in front of each line
vim.o.number = true
vim.o.relativenumber = true
-- Draw signcolumn always
vim.o.signcolumn = "yes"
-- Highlight the line number
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Keep 3 screen columns of context to the left and right of the cursor
vim.o.sidescrolloff = 3
-- Keep 5 screen lines of context above and below the cursor
vim.o.scrolloff = 5
-- Do not wrap long lines; scroll horizontally instead
vim.o.wrap = false

-- Insert spaces instead of tab characters in Insert mode and indents
vim.o.expandtab = true
-- Indent by 4 columns per level
vim.o.shiftwidth = 4
-- Display a tab character as 4 columns
vim.o.tabstop = 4
-- Use shiftwidth for soft tab stops so <Tab> and <BS> align to 4-column increments
vim.o.softtabstop = -1

-- Ignore case in search patterns, completion, and tag lookups
vim.o.ignorecase = true
-- Override ignorecase when the search pattern contains uppercase characters
vim.o.smartcase = true

-- Persist undo history to an undo file across sessions
vim.o.undofile = true

-- Place new vertical splits to the right of the current window
vim.o.splitright = true
-- Place new horizontal splits below the current window
vim.o.splitbelow = true

-- Disable custom fold text so closed folds display normally
vim.o.foldtext = ""
-- Keep nearly all folds open (level 99 exceeds any realistic fold depth)
vim.o.foldlevel = 99

-- Show invisible characters: tabs, trailing spaces, non-breaking spaces
vim.o.list = true
-- Display tabs as two spaces, trailing spaces as ·, and non-breaking spaces as +
vim.opt.listchars = {
	tab = "  ",
	trail = "·",
	nbsp = "+",
}

-- Suppress the Neovim banner message on startup
vim.opt.shortmess:append("I")

-- Use custom characters for fold markers, diff fillers, and end-of-buffer
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	foldinner = " ",
	diff = "╱",
	eob = " ",
}

-- Ignore common build and dependency directories during filename completion
vim.opt.wildignore:append({
	"*/node_modules/*",
	"*/dist/*",
	"*/build/*",
	"*/target/*",
})

if vim.fn.has("win32") == 1 and vim.fn.executable("pwsh") == 1 then
	vim.o.shelltemp = false
	vim.o.shell = "pwsh"
	vim.o.shellcmdflag = table.concat({
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command ",
		"[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();",
		"$PSDefaultParameterValues['Out-File:Encoding']='utf8';",
		"$PSStyle.OutputRendering = 'PlainText';",
	})
	vim.o.shellpipe = "> %s 2>&1"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
	vim.env.__SuppressAnsiEscapeSequences = "1"
end

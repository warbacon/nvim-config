-- Set the leader key to space and the local leader key to backslash
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Always show the sign column
vim.o.signcolumn = "yes"

-- Enable line numbers and relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Highlight the line number of the cursor's line
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Use spaces instead of tabs and set indentation size
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Customize fill characters
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- Folding oions
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.o.foldlevel = 99

-- Open new splits below and to the right of the current window
vim.o.splitbelow = true
vim.o.splitright = true

-- Ignore case in search patterns, but enable smart case
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show whitespace characters like tabs, trailing spaces, and non-breakable spaces
vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "+" }

-- Do not show the intro message on startup
vim.opt.shortmess:append({ I = true })

-- Enable persistent undo, allowing undo history to be saved between sessions
vim.o.undofile = true

-- Disable line wrapping
vim.o.wrap = false

-- Set minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 3
vim.o.scrolloff = 5

-- Limit the height of the popup menu
vim.o.pumheight = 10

-- Set the default shell based on availability and OS:
-- On Windows, use PowerShell if available.
-- Otherwise, use Fish shell if it's installed.
if util.is_win and vim.fn.executable("pwsh") then
    vim.o.shell = "pwsh -NoLogo"
    vim.o.shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command "
        .. "[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();"
        .. "$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
        .. "$PSStyle.OutputRendering='plaintext';"
        .. "Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
    vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
elseif vim.fn.executable("fish") then
    vim.o.shell = "fish"
end

-- Set global statusline
-- vim.o.laststatus = 3

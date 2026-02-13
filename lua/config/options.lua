vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = "yes"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.pumheight = 10

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.undofile = true

vim.o.cursorline = true
vim.o.cursorlineopt = "number"

vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "+" }

vim.o.sidescrolloff = 3
vim.o.scrolloff = 5
vim.o.wrap = false

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.foldtext = ""
vim.o.foldlevel = 99

vim.o.conceallevel = 3

vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

vim.opt.shortmess:append("I")

vim.o.winborder = "single"
if vim.fn.has("nvim-0.12") == 1 then
    vim.o.pumborder = vim.o.pumborder
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove({ "o" })
    end,
})

if vim.env.XDG_SESSION_TYPE ~= "tty" then
    vim.o.termguicolors = true
end

if vim.fn.has("linux") == 1 and vim.fn.executable("fish") == 1 then
    vim.o.shell = "fish"
end

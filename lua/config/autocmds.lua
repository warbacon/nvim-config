---@param name string
local function augroup(name)
    vim.api.nvim_create_augroup(name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("HightlightYank"),
    desc = "Automatically highlight text after yanking it",
    callback = function()
        vim.hl.on_yank()
    end,
})

autocmd("VimLeave", {
    group = augroup("FixCursor"),
    desc = "Fix the cursor when exiting Vim",
    callback = function()
        vim.o.guicursor = ""
        io.write("\x1b[ q")
    end,
})

autocmd("FileType", {
    group = augroup("Treesitter"),
    desc = "Enable treesitter highlighting",
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

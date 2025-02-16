---@param name string
local function augroup(name)
    vim.api.nvim_create_augroup(name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    desc = "Automatically highlight text after yanking it",
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

autocmd("VimLeave", {
    group = augroup("fix_cursor"),
    desc = "Fix the cursor when exiting Vim",
    callback = function()
        vim.o.guicursor = ""
        io.write("\x1b[ q")
    end,
})

autocmd("FileType", {
    group = augroup("TreeSitter"),
    desc = "Starts treesitter",
    callback = function()
        pcall(vim.treesitter.start)
    end
})

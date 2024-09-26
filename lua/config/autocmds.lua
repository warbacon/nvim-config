---@param name string
local function augroup(name)
    vim.api.nvim_create_augroup(name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- Automatically highlight text after yanking it
autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Fix the cursor when exiting Vim
autocmd("VimLeave", {
    group = augroup("fix_cursor"),
    callback = function()
        vim.opt.guicursor = ""
        io.write("\x1b[ q")
    end,
})

-- Remove automatic continuation of comments when creating a new line
autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove({ "o", "r" })
    end,
})

local autocmd = vim.api.nvim_create_autocmd

-- Automatically highlight text after yanking it
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Fix the cursor when exiting Vim
autocmd("VimLeave", {
    callback = function()
        vim.opt.guicursor = ""
        io.write("\x1b[ q")
    end,
})

-- Remove automatic continuation of comments when creating a new line
autocmd("FileType", {
    callback = function()
        vim.opt.formatoptions:remove({ "o", "r" })
    end,
})

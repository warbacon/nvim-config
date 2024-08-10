local autocmd = vim.api.nvim_create_autocmd

-- Fix cursor at leave
autocmd("VimLeave", {
    callback = function()
        vim.opt.guicursor = ""
        vim.api.nvim_chan_send(vim.api.nvim_get_vvar("stderr"), "\x1b[ q")
    end,
})

-- Highlight when yanking text
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Disable auto comment
autocmd("FileType", {
    callback = function()
        vim.opt.formatoptions:remove({ "o", "r" })
    end,
})

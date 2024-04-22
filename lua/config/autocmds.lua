-- Fix cursor at leave
vim.api.nvim_create_autocmd("VimLeave", {
    command = [[set guicursor= | call chansend(v:stderr, "\x1b[ q")]],
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

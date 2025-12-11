-- Automatically highlight text after yanking it
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ timeout = 100 })
    end,
})

-- Fix the cursor when exiting Vim
vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        vim.o.guicursor = ""
        io.write("\x1b[ q")
    end,
})

-- Remove the `How to disable mouse` entry from the PopUp menu
vim.cmd([[
unmenu PopUp.-2-
unmenu PopUp.How-to\ disable\ mouse
]])

-- Improve filetype support
vim.filetype.add({
    pattern = {
        ["%.env.*"] = "sh",
    },
})

-- Human error correction
vim.api.nvim_create_user_command("W", "w<bang>", { bang = true })
vim.api.nvim_create_user_command("Q", "q<bang>", { bang = true })
vim.api.nvim_create_user_command("Wq", "wq<bang>", { bang = true })

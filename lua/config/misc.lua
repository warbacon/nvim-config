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

-- HACK: move Windows entries to end of PATH in WSL to improve performance
if vim.fn.has("wsl") == 1 then
    local path_sep = ":"
    local original_path = vim.env.PATH
    local linux_paths = {}
    local windows_paths = {}

    for entry in string.gmatch(original_path, "([^" .. path_sep .. "]+)") do
        if entry:match("^/mnt/") then
            table.insert(windows_paths, entry)
        else
            table.insert(linux_paths, entry)
        end
    end

    vim.env.PATH = table.concat(vim.list_extend(linux_paths, windows_paths), path_sep)
end

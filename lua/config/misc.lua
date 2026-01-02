vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Automatically highlight text after yanking it",
    callback = function()
        vim.hl.on_yank({ timeout = 100 })
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    desc = "Fix the cursor when exiting Vim",
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
    local original_path = vim.env.PATH
    local linux_paths = {}
    local windows_paths = {}

    for entry in original_path:gmatch("([^:]+)") do
        if entry:sub(1, 5) == "/mnt/" then
            windows_paths[#windows_paths + 1] = entry
        else
            linux_paths[#linux_paths + 1] = entry
        end
    end

    vim.env.PATH = table.concat(linux_paths, ":") .. ":" .. table.concat(windows_paths, ":")
end

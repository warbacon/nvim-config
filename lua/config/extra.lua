-- Configure diagnostics
---@type vim.diagnostic.Opts
vim.diagnostic.config({
    severity_sort = true,
    virtual_text = true,
    signs = {
        text = Util.icons.diagnostics,
    },
})

-- Remove the `How to disable mouse` entry from the PopUp menu
vim.cmd([[
if has("nvim-0.11")
    unmenu PopUp.-2-
else
    unmenu PopUp.-1-
endif
unmenu PopUp.How-to\ disable\ mouse
]])

-- Make clipboard work in WSL
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

-- Improve filetype support
vim.filetype.add({
    filename = {
        dunstrc = "dosini",
    },
    pattern = {
        ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
    },
})

-- Human error correction
vim.api.nvim_create_user_command("W", "w<bang>", { bang = true })
vim.api.nvim_create_user_command("Q", "q<bang>", { bang = true })
vim.api.nvim_create_user_command("Wq", "wq<bang>", { bang = true })

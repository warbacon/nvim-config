-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Add support for the LazyFile event
local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile" } }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = {
        colorscheme = { "tokyonight-night" }
    },
    checker = {
        enabled = true
    },
    defaults = {
        cond = vim.env.DISPLAY == nil and Util.is_linux,
    },
    performance = {
        rtp = {
            paths = Util.is_linux and { "/usr/share/nvim/site" } or {},
        },
    },
})

-- Set keymap
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

-- Clone lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Enable LazyFile event
require("util").lazy_file()

-- Lazy.nvim options
local opts = {
    ui = { backdrop = 100 },
    change_detection = { notify = false },
    install = { colorscheme = { "catppuccin" } },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}

-- Start lazy.nvim
require("lazy").setup("plugins", opts)

-- Lazy.nvim keymap
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { silent = true })

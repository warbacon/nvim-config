-- Clone lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
require("lazyfile").setup()

-- Start lazy.nvim
require("lazy").setup({
    spec = "plugins",
    ui = { backdrop = 100 },
    change_detection = { notify = false },
    install = { colorscheme = { "kanagawa", "tokyonight", "catppuccin" } },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "rplugin",
                "spellfile",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- Lazy.nvim keymap
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { silent = true })

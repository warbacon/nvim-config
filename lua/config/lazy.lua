local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

if vim.fn.has("nvim-0.10") == 0 then
    vim.uv = vim.uv or vim.loop -- needed to make LazyFile work
end

require("util").lazy_file()

local opts = {
    change_detection = { notify = false },
    install = {
        missing = true,
        colorscheme = { "catppuccin", "habamax" },
    },
    ui = { backdrop = 100 },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "netrw",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}

require("lazy").setup("plugins", opts)

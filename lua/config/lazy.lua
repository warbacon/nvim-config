-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "plugins.mini" },
    },
    install = {
        colorscheme = { "tokyonight", "retrobox" },
    },
    ui = { backdrop = 100 },
    change_detection = { notify = false },
})

vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>Lazy<cr>", {})

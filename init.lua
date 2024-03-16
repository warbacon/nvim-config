-- Set leader-key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
require("options")

-- Keymaps
require("keymaps")

-- Autocmds
require("autocmds")

-- Lazy.nvim
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

-- Plugins
require("lazy").setup("plugins", {
	change_detection = { notify = false },
	disabled_plugins = {
		"gzip",
		"matchit",
		"tarPlugin",
		"tohtml",
		"tutor",
		"zipPlugin",
	},
})

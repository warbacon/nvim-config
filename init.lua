-- Set leader-key to space
vim.g.mapleader = " "

-- Options
require("options")

-- Keymaps
require("keymaps")

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

local plugins = require("plugins")
local opts = {
	performance = {
		disabled_plugins = { "netrwPlugin", "tutor" },
	},
}

require("lazy").setup(plugins, opts)

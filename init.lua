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

require("lazy").setup("plugins", {
	change_detection = { notify = false },
})

-- Fix cursor at leave
vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	command = [[set guicursor= | call chansend(v:stderr, "\x1b[ q")]],
})

-- Add hyprlang filetype
vim.filetype.add({
	pattern = { [".*/hypr.*"] = "hyprlang" },
})

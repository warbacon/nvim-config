-- Set leader-key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
require("options")

-- Keymaps
require("keymaps")

-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup("plugins", {
	change_detection = { notify = false },
})

-- Fix cursor at leave
vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	command = [[set guicursor= | call chansend(v:stderr, "\x1b[ q")]],
})

-- Remove traling whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Add hyprlang filetype
vim.filetype.add({
	pattern = { [".*/hypr.*.conf"] = "hyprlang" },
})

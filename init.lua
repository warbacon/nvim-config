-- Set leader-key to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load config
require("config")

-- LAZY[START] ------------------------------------------------------------------
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

local opts = {
	install = {
		colorscheme = { "kanagawa", "catppuccin", "habamax" },
	},
	change_detection = {
		notify = false,
	},
}

require("lazy").setup("plugins", opts)
-- LAZY[END] -------------------------------------------------------------------

-- Fix clipboard in WSL
if vim.fn.has("wsl") == 1 then
	vim.cmd([[
    let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': 'clip.exe',
                \      '*': 'clip.exe',
                \    },
                \   'paste': {
                \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }
    ]])
end

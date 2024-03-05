-- Remove traling whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Fix cursor at leave
vim.api.nvim_create_autocmd("VimLeave", {
	command = [[set guicursor= | call chansend(v:stderr, "\x1b[ q")]],
})

-- Disable numbers and signcolumn in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Create directory if it does not exist when saving
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(ev)
		local dirname = vim.fs.dirname(ev.match)
		vim.loop.fs_mkdir(dirname, tonumber("0755", 8))
	end,
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

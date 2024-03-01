-- Remove traling whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Fix cursor at leave
vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	command = [[set guicursor= | call chansend(v:stderr, "\x1b[ q")]],
})

-- Disable numbers and signcolumn in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = [[setlocal nonumber norelativenumber signcolumn=no]],
})

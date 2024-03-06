-- Remove traling whitespace and new lines on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		-- Save cursor position to later restore
		local curpos = vim.api.nvim_win_get_cursor(0)
		-- Search and replace trailing whitespace
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, curpos)

		-- Remove new lines
		local n_lines = vim.api.nvim_buf_line_count(0)
		local last_nonblank = vim.fn.prevnonblank(n_lines)
		if last_nonblank + 1 < n_lines then
			vim.api.nvim_buf_set_lines(0, last_nonblank + 1, n_lines, true, {})
		end
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

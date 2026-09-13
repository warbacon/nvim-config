vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ev)
		vim.wo.colorcolumn = vim.bo[ev.buf].filetype == "markdown" and "80" or ""
	end,
})

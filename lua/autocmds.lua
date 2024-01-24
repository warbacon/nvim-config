vim.api.nvim_create_autocmd("BufEnter", { command = "set formatoptions-=cro" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "zsh", "sh" },
	command = [[
    set tabstop=2
    set shiftwidth=2
    ]],
})

vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	command = [[set guicursor= | call chansend(v:stderr, "\x1b[ q")]],
})

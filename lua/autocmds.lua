vim.api.nvim_create_autocmd("BufEnter", { command = "set formatoptions-=cro" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "zsh", "sh" },
	command = [[
    set tabstop=2
    set shiftwidth=2
    ]],
})

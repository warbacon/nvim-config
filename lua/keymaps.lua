-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y$')

-- Disable the `q:` command-line window
vim.keymap.set("n", "q:", "<cmd>echoe 'q:'<CR>", { noremap = true })

-- <C-t> annoys me
vim.keymap.set("i", "<C-t>", "<nop>", { noremap = true })

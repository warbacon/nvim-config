vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '<S-v>"+y')

vim.keymap.set("n", "q:", "<nop>", { noremap = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

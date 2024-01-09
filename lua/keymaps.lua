vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '<S-v>"+y')

vim.keymap.set("n", "q:", "<nop>", { noremap = true, silent = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })

vim.keymap.set("n", "-", "<cmd>Explore<cr>")

vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '<S-v>"+y')

vim.keymap.set("n", "<leader>h", '<CMD>bprevious<CR>')
vim.keymap.set("n", "<leader>l", '<CMD>bnext<CR>')

vim.api.nvim_set_keymap("n", "q:", "<nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "Q", "<nop>", { noremap = true, silent = true })

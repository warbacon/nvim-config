-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '<S-v>"+y')

-- Next and previous buffer
vim.keymap.set("n", "<tab>", vim.cmd.bnext)
vim.keymap.set("n", "<s-tab>", vim.cmd.bprevious)

-- Lazy.nvim
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

-- Miscellaneous
vim.keymap.set("n", "q:", "<nop>", { noremap = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true })

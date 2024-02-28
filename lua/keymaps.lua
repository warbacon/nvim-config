-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selected text to clipboard" })
vim.keymap.set("n", "<leader>yy", '<S-v>"+y', { desc = "Copy line to clipboard" })

-- Miscellaneous
vim.keymap.set("n", "q:", "<nop>", { noremap = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true })

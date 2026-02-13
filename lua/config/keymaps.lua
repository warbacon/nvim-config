-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = true, desc = "Go to definition" })
    end,
})

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y$', { desc = "Copy until the end to system clipboard" })

-- Allow <C-v> to paste text
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste using system's clipboard" })

-- Allow <C-z> to undo
vim.keymap.set("i", "<C-z>", "<Cmd>undo<CR>", { desc = "Undo last change" })

-- Sensible word deleting in insert and command-line mode
vim.keymap.set({ "i", "c" }, "<C-BS>", "<C-w>", { desc = "Delete backward word" })
vim.keymap.set({ "i", "c" }, "<M-BS>", "<C-w>", { desc = "Delete backward word" })

-- Fuzzy finder replacement
vim.keymap.set("n", "<Leader>f", ":find **/", { noremap = true, desc = "Find files" })

-- Restart Neovim
if vim.fn.has("nvim-0.12") == 1 then
    vim.keymap.set("n", "<Leader>rr", "<Cmd>restart<CR>", { desc = "Confirm restart" })
end

-- Use <M-q> to exit terminal mode
vim.keymap.set("t", "<M-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable the `q:` command-line window
vim.keymap.set("n", "q:", "<Cmd>echoe 'q:'<CR>", { noremap = true, desc = "Disabled command-line window" })

-- Open netrw
vim.keymap.set("n", "-", "<Cmd>Explore<CR>", { noremap = true, desc = "Open file explorer" })

-- Disable <C-t> in insert mode
vim.keymap.set("i", "<C-t>", "<nop>", { noremap = true, desc = "Disabled (annoying keybind)" })

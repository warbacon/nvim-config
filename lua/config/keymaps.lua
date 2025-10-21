-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = true })
    end,
})

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y$')

-- Paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')

-- Fuzzy finder replacement
vim.keymap.set("n", "<Leader>f", ":find **/", { noremap = true })

-- Restart Neovim
if vim.fn.has("nvim-0.12") then
    vim.keymap.set("n", "<Leader>rr", "<Cmd>restart<CR>")
end

-- Use <Esc> to exit terminal mode
vim.keymap.set("t", "<M-q>", "<C-\\><C-n>")

-- Disable the `q:` command-line window
vim.keymap.set("n", "q:", "<cmd>echoe 'q:'<CR>", { noremap = true })

-- <C-t> annoys me
vim.keymap.set("i", "<C-t>", "<nop>", { noremap = true })

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y$')

-- Set up keymaps for LSP features when an LSP client is attached to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspActions", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
    end,
})

-- Disable the `q:` command-line window
vim.keymap.set("n", "q:", "<cmd>echoe 'q:'<CR>", { noremap = true })

-- <C-t> annoys me
vim.keymap.set("i", "<C-t>", "<nop>", { noremap = true })

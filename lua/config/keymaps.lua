-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '<S-v>"+y')

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>H", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
        end)
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
        vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<cr>")
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>")
    end,
})

-- Snippets
vim.keymap.set({ "i", "s" }, "<c-l>", function()
    return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-h>", function()
    return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, { silent = true })

-- Miscellaneous
vim.keymap.set("n", "q:", "<cmd>echoe 'q:'<cr>", { noremap = true })

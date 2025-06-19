return {
    "neovim/nvim-lspconfig",
    config = function()
        for server, opts in pairs(vim.g.lsp_servers) do
            vim.lsp.config(server, opts)
            vim.lsp.enable(server)
        end
    end,
}

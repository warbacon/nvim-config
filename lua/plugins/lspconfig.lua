return {
    "neovim/nvim-lspconfig",
    config = function()
        for server, opts in pairs(Util.lsp_servers) do
            vim.lsp.config(server, opts)
            vim.lsp.enable(server)
        end
    end,
}

return {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    cmd = { "LspInfo", "LspLog", "LspStop", "LspStart" },
    config = function()
        for server, opts in pairs(Util.lsp_servers) do
            vim.lsp.config(server, opts)
            vim.lsp.enable(server)
        end
    end,
}

return {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    config = function()
        local servers = Util.lsp_servers

        for _, server in ipairs(servers) do
            vim.lsp.enable(server)
        end
    end,
}

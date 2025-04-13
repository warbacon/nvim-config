return {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    config = function()
        local servers = vim.deepcopy(require("config.servers"), true)

        for server_name, opts in pairs(servers) do
            vim.lsp.config(server_name, opts)
            vim.lsp.enable(server_name)
        end
    end,
}

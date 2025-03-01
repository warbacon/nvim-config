return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason.nvim",
    },
    event = "LazyFile",
    cmd = { "LspInfo", "LspStop", "LspStart", "LspLog", "LspRestart" },
    config = function()
        local servers = vim.deepcopy(require("config.servers"), true)

        for server_name, opts in pairs(servers) do
            opts.capabilities = require("blink-cmp").get_lsp_capabilities()
            require("lspconfig")[server_name].setup(opts)
        end
    end,
}

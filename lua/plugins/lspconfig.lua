return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason.nvim",
    },
    event = "LazyFile",
    cmd = { "LspInfo", "LspStop", "LspStart", "LspLog", "LspRestart" },
    config = function()
        local servers = vim.deepcopy(require("config.servers"), true)

        local has_blink, blink_cmp = pcall(require, "blink-cmp")

        for server_name, opts in pairs(servers) do
            opts.capabilities = has_blink and blink_cmp.get_lsp_capabilities(opts.capabilities or {}, true)
                or opts.capabilities
            require("lspconfig")[server_name].setup(opts)
        end
    end,
}

return {
    -- SCHEMASTORE =============================================================
    { "b0o/SchemaStore.nvim", lazy = true },

    -- FIDGET ==================================================================
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            progress = {
                display = {
                    render_limit = 4,
                    done_ttl = 1,
                    done_icon = "󰄬",
                },
            },
        },
    },

    -- LAZYDEV =================================================================
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },

    -- LSPCONFIG ===============================================================
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "mason.nvim",
        },
        config = function()
            local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp_lsp and cmp_lsp.default_capabilities() or {}
            )

            local servers = require("util.lsp").servers
            for server_name in pairs(servers) do
                local server_opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, servers[server_name])
                require("lspconfig")[server_name].setup(server_opts)
            end
        end,
    },
}

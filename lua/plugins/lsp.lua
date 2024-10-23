return {
    -- SCHEMASTORE =============================================================
    { "b0o/SchemaStore.nvim", lazy = true },

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

    -- JDTLS ===================================================================
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            local function attach_jdtls()
                local fname = vim.api.nvim_buf_get_name(0)

                local config = {
                    cmd = { vim.fn.exepath("jdtls") },
                    root_dir = require("lspconfig.configs.jdtls").default_config.root_dir(fname),
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                }

                require("jdtls").start_or_attach(config)
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("start-jdtls", { clear = true }),
                pattern = { "java" },
                callback = attach_jdtls,
            })
        end,
    },

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

            servers.jdtls = nil

            for server_name in pairs(servers) do
                local server_opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, servers[server_name])
                require("lspconfig")[server_name].setup(server_opts)
            end
        end,
    },
}

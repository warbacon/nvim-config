return {
    -- SCHEMASTORE ============================================================
    { "b0o/SchemaStore.nvim", lazy = true },

    -- LAZYDEV ================================================================
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },

    -- JDTLS ==================================================================
    {
        "mfussenegger/nvim-jdtls",
        enabled = vim.fn.executable("java"),
        ft = "java",
        config = function()
            local function attach_jdtls()
                local fname = vim.api.nvim_buf_get_name(0)

                local config = {
                    cmd = { vim.fn.exepath("jdtls") },
                    root_dir = require("lspconfig.configs.jdtls").default_config.root_dir(fname),
                    capabilities = require("blink-cmp").get_lsp_capabilities(),
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

    -- LSPCONFIG ==============================================================
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        dependencies = {
            "mason.nvim",
        },
        config = function()
            local servers = vim.deepcopy(Util.lsp.servers)
            servers.jdtls = nil

            for server_name in pairs(servers) do
                local server_opts = vim.tbl_deep_extend(
                    "force",
                    { capabilities = require("blink-cmp").get_lsp_capabilities() },
                    servers[server_name]
                )
                require("lspconfig")[server_name].setup(server_opts)
            end
        end,
    },
}

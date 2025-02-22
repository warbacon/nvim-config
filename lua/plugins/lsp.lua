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
                { path = "mini.icons", words = { "MiniIcons" } },
            },
        },
    },

    -- JDTLS ==================================================================
    {
        "mfussenegger/nvim-jdtls",
        enabled = require("config.lsp-servers").jdtls,
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
                group = vim.api.nvim_create_augroup("jdtls", { clear = true }),
                desc = "Checks whether server jdtls should start a new instance or attach to an existing one.",
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
            local servers = vim.deepcopy(require("config.lsp-servers"), true)

            for server, opts in pairs(servers) do
                opts.capabilities = require("blink-cmp").get_lsp_capabilities(opts.capabilities)
                require("lspconfig")[server].setup(opts)
            end
        end,
    },
}

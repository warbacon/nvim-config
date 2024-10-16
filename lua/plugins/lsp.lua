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
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0,
            })
        end,
    },

    -- JAVA ===============================================================
    {
        "mfussenegger/nvim-jdtls",
        enabled = vim.fn.executable("java"),
        ft = "java",
        dependencies = {
            "mason.nvim",
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("start_jdtls", { clear = true }),
                pattern = { "java" },
                callback = function()
                    require("jdtls").start_or_attach({ cmd = { vim.fn.exepath("jdtls") } })
                end,
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
            local has_cmp_lsp = pcall(require, "cmp_nvim_lsp")

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp_lsp and require("cmp_nvim_lsp").default_capabilities() or {}
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

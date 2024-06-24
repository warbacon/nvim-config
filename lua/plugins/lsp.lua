-- Declare LSP servers
local servers = {
    basedpyright = {},
    bashls = {},
    clangd = {},
    jsonls = {
        on_new_config = function(new_config)
            new_config.settings.json.schemas = require("schemastore").json.schemas()
        end,
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                completion = { callSnippet = "Replace" },
                hint = { enable = true },
            },
        },
    },
    taplo = {},
    yamlls = {
        on_new_config = function(new_config)
            new_config.settings.yaml.schemas = require("schemastore").yaml.schemas()
        end,
        settings = {
            yaml = {
                schemaStore = { enable = false, url = "" },
            },
        },
    },
}

return {
    -- FIDGET.NVIM =============================================================
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            notification = {
                window = { winblend = 0 },
            },
        },
    },

    -- MASON.NVIM ==============================================================
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        event = "VeryLazy",
        keys = { { "<leader>m", "<cmd>Mason<cr>", mode = "n" } },
        opts = {
            ensure_installed = {
                "clang-format",
                "markdownlint",
                "ruff",
                "shellcheck",
                "shfmt",
                "stylua",
            },
        },
        config = function(_, opts)
            if vim.fn.has("win32") == 1 then
                servers.clangd = nil
                servers.bashls = nil
            end

            local ensure_installed = opts.ensure_installed

            vim.list_extend(ensure_installed, vim.tbl_keys(servers))
            require("mason").setup()
            require("mason-lspconfig").setup()
            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
            })
        end,
    },

    -- LAZYDEV.NVIM ============================================================
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = { { path = "luvit-meta/library", words = { "vim%.uv" } } },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },

    -- SCHEMASTORE.NVIM ========================================================
    { "b0o/SchemaStore.nvim", lazy = true },

    -- NVIM-LSPCONFIG ==========================================================
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        dependencies = {
            "mason.nvim",
        },
        opts = {
            diagnostics = {
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
            },
        },
        config = function(_, opts)
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities() or {},
                opts.capabilities or {}
            )

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    local server_opts = vim.tbl_deep_extend("force", {
                        capabilities = vim.deepcopy(capabilities),
                    }, servers[server_name] or {})

                    require("lspconfig")[server_name].setup(server_opts)
                end,
            })
        end,
    },
}

-- Declare LSP servers
local servers = {
    basedpyright = {},
    bashls = {},
    clangd = {},
    powershell_es = {
        settings = {
            powershell = {
                codeFormatting = {
                    preset = "Stroustrup",
                },
            },
        },
    },
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
                window = { winblend = 10 },
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

            if vim.fn.executable("pwsh") == 0 then
                servers.powershell_es = nil
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
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
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
        config = function()
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities() or {}
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

    -- NONE-LS =================================================================
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local none_ls = require("null-ls")

            none_ls.setup({
                sources = {
                    none_ls.builtins.diagnostics.zsh,
                    none_ls.builtins.diagnostics.fish,
                    none_ls.builtins.diagnostics.markdownlint.with({
                        extra_args = { "--disable=MD033" },
                    }),
                },
            })
        end,
    },
}

-- Declare LSP servers
local servers = {
    astro = {},
    basedpyright = {},
    svelte = {},
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
                completion = { callSnippet = "Replace" },
            },
        },
    },
    powershell_es = {
        settings = {
            powershell = {
                codeFormatting = { preset = "Stroustrup" },
            },
        },
    },
    tailwindcss = { filetypes_exclude = { "markdown" } },
    taplo = {},
    vtsls = {},
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
    -- FIDGET ==================================================================
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            notification = {
                window = { winblend = 10 },
            },
        },
    },

    -- MASON ===================================================================
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
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = " ",
                    package_uninstalled = " ",
                },
            },
            ensure_installed = {
                "clang-format",
                "prettierd",
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
            require("mason").setup({ ui = opts.ui })
            require("mason-lspconfig").setup()
            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
            })
        end,
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

    -- SCHEMASTORE =============================================================
    { "b0o/SchemaStore.nvim", lazy = true },

    -- LSPCONFIG ===============================================================
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "mason.nvim",
        },
        opts = {
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.HINT] = "",
                    [vim.diagnostic.severity.INFO] = "",
                },
            },
        },
        config = function(_, opts)
            vim.diagnostic.config(opts)

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
                ["ruff"] = function() end,
            })
        end,
    },
}

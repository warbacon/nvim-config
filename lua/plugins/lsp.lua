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
                workspace = { checkThirdParty = false },
                codeLens = { enable = true },
                completion = { callSnippet = "Replace" },
                doc = { privateName = { "^_" } },
                hint = {
                    enable = true,
                    setType = false,
                    paramType = true,
                    paramName = "Disable",
                    semicolon = "Disable",
                    arrayIndex = "Disable",
                },
            },
        },
    },
    powershell_es = { settings = { powershell = { codeFormatting = { preset = "Stroustrup" } } } },
    tailwindcss = { filetypes_exclude = { "markdown" } },
    taplo = {},
    vtsls = {
        settings = {
            complete_function_calls = true,
            vtsls = {
                tsserver = {
                    globalPlugins = {
                        name = "@astrojs/ts-plugin",
                        location = vim.fn.stdpath("data")
                            .. "/mason/packages/astro-language-server/node_modules/@astrojs/ts-plugin",
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                    enableMoveToFileCodeAction = true,
                    autoUseWorkspaceTsdk = true,
                    experimental = { completion = { enableServerSideFuzzyMatch = true } },
                },
                typescript = {
                    updateImportsOnFileMove = { enabled = "always" },
                    suggest = { completeFunctionCalls = true },
                    inlayHints = {
                        enumMemberValues = { enabled = true },
                        functionLikeReturnTypes = { enabled = true },
                        parameterNames = { enabled = "literals" },
                        parameterTypes = { enabled = true },
                        propertyDeclarationTypes = { enabled = true },
                        variableTypes = { enabled = false },
                    },
                },
            },
        },
    },
    yamlls = {
        on_new_config = function(new_config)
            new_config.settings.yaml.schemas = require("schemastore").yaml.schemas()
        end,
        settings = { yaml = { schemaStore = { enable = false, url = "" } } },
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

    -- INC-RENAME ==============================================================
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        opts = {},
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
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = " ",
                    package_uninstalled = " ",
                },
            },
            ensure_installed = {
                "clang-format",
                "markdownlint",
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
        event = "File",
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
        ft = { "markdown", "fish", "zsh" },
        dependencies = {
            "mason.nvim",
        },
        config = function()
            local none_ls = require("null-ls")

            none_ls.setup({
                sources = {
                    none_ls.builtins.diagnostics.fish,
                    none_ls.builtins.diagnostics.zsh,
                    none_ls.builtins.diagnostics.markdownlint.with({
                        extra_args = { "--disable=MD033" },
                    }),
                },
            })
        end,
    },
}

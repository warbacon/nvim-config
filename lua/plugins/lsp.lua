return {
    -- FIDGET.NVIM -------------------------------------------------------------
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            notification = {
                window = { winblend = 0 },
            },
        },
    },

    -- MASON.NVIM --------------------------------------------------------------
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>m", "<cmd>Mason<cr>" } },
        build = ":MasonUpdate",
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
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },

    -- NVIM-LSPCONFIG ----------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "b0o/SchemaStore.nvim",
            {
                "folke/neodev.nvim",
                opts = { library = { plugins = { "catppuccin" } } },
            },
        },
        opts = {
            servers = {
                basedpyright = {},
                bashls = {},
                clangd = {},
                jsonls = {
                    json = {
                        format = { enable = true },
                        validate = { enable = true },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            hint = { enable = true },
                            completion = { callSnippet = "Replace" },
                        },
                    },
                },
                taplo = {},
                yamlls = {
                    settings = {
                        redhat = { telemetry = { enabled = false } },
                        yaml = {
                            keyOrdering = false,
                            format = { enable = true },
                            validate = true,
                            schemaStore = { enable = false, url = "" },
                        },
                    },
                },
            },
            diagnostics = {
                virtual_text = {
                    prefix = function(diagnostic)
                        local icons = require("util").icons.diagnostics
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return icon
                            end
                        end
                    end,
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = require("util").icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = require("util").icons.diagnostics.Warn,
                        [vim.diagnostic.severity.HINT] = require("util").icons.diagnostics.Hint,
                        [vim.diagnostic.severity.INFO] = require("util").icons.diagnostics.Info,
                    },
                },
            },
        },
        config = function(_, opts)
            local servers = opts.servers

            if vim.fn.has("win32") == 1 then
                servers.clangd.enabled = false
                servers.bashls.enabled = false
            end

            servers.jsonls.json.schemas = require("schemastore").json.schemas()
            servers.yamlls.settings.schemas = require("schemastore").yaml.schemas()

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

            local ensure_installed = {}
            for server, server_opts in pairs(servers) do
                if server_opts then
                    if not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    elseif server_opts.enabled ~= false then
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                handlers = { setup },
            })
        end,
    },
}

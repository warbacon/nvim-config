-- LSP servers options ---------------------------------------------------------
local servers = {
    basedpyright = {},
    bashls = {},
    clangd = {},
    jsonls = { settings = { json = { validate = { enable = true } } } },
    lua_ls = {
        settings = { Lua = { completion = { callSnippet = "Replace" } } },
    },
    taplo = {},
    yamlls = {
        settings = { yaml = { schemaStore = { enable = false, url = "" } } },
    },
}

-- Disable clangd and bashls in Windows
if vim.fn.has("win32") == 1 then
    servers.clangd = nil
    servers.bashls = nil
end

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
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        build = ":MasonUpdate",
        event = "VeryLazy",
        cmd = "Mason",
        keys = { { "<leader>m", "<cmd>Mason<cr>" } },
        config = function()
            local ensure_installed = vim.tbl_keys(servers)

            vim.list_extend(ensure_installed, {
                "clang-format",
                "markdownlint",
                "ruff",
                "shfmt",
                "stylua",
                "shellcheck",
            })

            require("mason").setup()
            require("mason-lspconfig").setup()
            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
            })
        end,
    },

    -- NVIM-LSPCONFIG ---------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        dependencies = {
            "mason.nvim",
            "b0o/SchemaStore.nvim",
            { "folke/neodev.nvim", opts = { library = { plugins = false } } },
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            servers.jsonls.settings.schemas = require("schemastore").json.schemas()
            servers.yamlls.settings.schemas = require("schemastore").yaml.schemas()

            for server, opts in pairs(servers) do
                opts.capabilities = capabilities
                require("lspconfig")[server].setup(opts)
            end
        end,
    },

    -- NONE-LS.NVIM ------------------------------------------------------------
    {
        "nvimtools/none-ls.nvim",
        event = "LazyFile",
        dependencies = { "mason.nvim" },
        opts = function()
            local diagnostics = require("null-ls").builtins.diagnostics

            return {
                sources = {
                    diagnostics.fish,
                    diagnostics.zsh,
                    diagnostics.markdownlint.with({
                        extra_args = { "--disable=MD033" },
                    }),
                },
            }
        end,
    },
}

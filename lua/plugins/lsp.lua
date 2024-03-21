local servers = {
    bashls = {},
    clangd = {},
    basedpyright = {},
    powershell_es = {
        settings = {
            powershell = { codeFormatting = { Preset = "OTBS" } },
        },
    },
    lua_ls = {
        settings = {
            Lua = { completion = { callSnippet = "Replace" } },
        },
    },
}

local utilities = {
    "clang-format",
    "markdownlint",
    "ruff",
    "shfmt",
    "stylua",
}

if require("util").on_windows then
    servers.clang = nil
    servers.bashls = nil
else
    servers.powershell_es = nil
end

if servers.bashls ~= nil then
    table.insert(utilities, "shellcheck")
end

return {
    -- MASON.NVIM -------------------------------------------------------------
    {
        "williamboman/mason.nvim",
        lazy = false,
        keys = { { "<leader>m", "<cmd>Mason<cr>", mode = "n" } },
        build = ":MasonUpdate",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local ensure_installed = utilities

            vim.list_extend(ensure_installed, vim.tbl_keys(servers))

            require("mason").setup({})
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
        end,
    },

    -- NVIM-LSPCONFIG ---------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        dependencies = {
            "mason.nvim",
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            require("mason-lspconfig").setup()

            -- Set lsp capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.bo[ev.buf].formatexpr = nil  -- makes gq work
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
                    end, opts)
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })

            for server, opts in pairs(servers) do
                opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
                require("lspconfig")[server].setup(opts)
            end
        end,
    },

    -- NONE-LS.NVIM -----------------------------------------------------------
    {
        "nvimtools/none-ls.nvim",
        event = "LazyFile",
        opts = function()
            local null_ls = require("null-ls")
            return {
                sources = {
                    null_ls.builtins.diagnostics.fish,
                    null_ls.builtins.diagnostics.markdownlint,
                    null_ls.builtins.diagnostics.zsh,
                },
            }
        end,
    },
}

return {
    {
        "neovim/nvim-lspconfig",
        lazy = vim.fn.argc(-1) == 0,
        event = "VeryLazy",
        config = function()
            vim.lsp.enable({
                "bashls",
                "clangd",
                "cssls",
                "emmet_language_server",
                "gopls",
                "html",
                "jdtls",
                "jsonls",
                "lua_ls",
                "nixd",
                "oxlint",
                "svelte",
                "qmlls",
                "tailwindcss",
                "vtsls",
                "yamlls",
            })
        end,
    },
    ---@module "lazydev"
    ---@type lazydev.Config
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
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
    },
}

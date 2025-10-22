return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "mfussenegger/nvim-jdtls" },
        config = function()
            vim.lsp.enable({
                "astro",
                "basedpyright",
                "bashls",
                "clangd",
                "cssls",
                "emmet_language_server",
                "gopls",
                "html",
                "intelephense",
                "jdtls",
                "jsonls",
                "lua_ls",
                "nixd",
                "qmlls",
                "svelte",
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
}

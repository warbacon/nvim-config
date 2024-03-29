return {
    -- NVIM-TREESITTER --------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        init = function()
            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })
        end,
        event = { "LazyFile", "VeryLazy" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "diff",
                "fish",
                "gitcommit",
                "html",
                "hyprlang",
                "json",
                "jsonc",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
    },
}

return {
    -- NVIM-TREESITTER --------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "LazyFile", "VeryLazy" },
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "diff",
                "fish",
                "gitcommit",
                "hyprlang",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            indent = { enable = true },
            highlight = {
                enable = true,
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
        config = function(_, opts)
            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}

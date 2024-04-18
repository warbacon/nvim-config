return {
    -- NVIM-TREESITTER --------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "andymass/vim-matchup",
            config = function()
                vim.g.matchup_matchparen_offscreen = { method = "scrolloff" }
                vim.g.matchup_matchparen_deferred = 1
            end,
        },
        main = "nvim-treesitter.configs",
        init = function()
            -- Add hyprlang filetype
            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })
        end,
        event = { "LazyFile", "VeryLazy" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            matchup = { enable = true },
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

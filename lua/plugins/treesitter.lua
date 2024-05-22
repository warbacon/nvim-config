return {
    -- NVIM-TREESITTER ---------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "LazyFile", "VeryLazy" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        init = function()
            -- Add hyprlang filetype
            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })
        end,
        main = "nvim-treesitter.configs",
        opts = {
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
                "query",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            highlight = { enable = true },
            additional_vim_regex_highlighting = false,
            textobjects = { select = { enable = true } },
        },
    },
}

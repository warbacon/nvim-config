return {
    -- TRESITTER ===============================================================
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0,
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "dockerfile",
                "fish",
                "git_config",
                "html",
                "hyprlang",
                "ini",
                "java",
                "javascript",
                "json",
                "jsonc",
                "lua",
                "markdown",
                "markdown_inline",
                "powershell",
                "python",
                "query",
                "rasi",
                "toml",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "zathurarc",
            },
        },
        config = function(_, opts)
            vim.filetype.add({ pattern = { [".*/dunst/dunstrc"] = "dosini" } })
            require("nvim-treesitter.install").prefer_git = false
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- TS-AUTOTAG ==============================================================
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.defer_fn(function()
                require("nvim-ts-autotag").setup()
            end, 1)
        end,
    },
}

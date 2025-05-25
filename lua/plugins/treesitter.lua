return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()
            require("nvim-treesitter").install({
                "bash",
                "blade",
                "c",
                "cpp",
                "css",
                "dockerfile",
                "fish",
                "git_config",
                "gitcommit",
                "html",
                "hyprlang",
                "ini",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "nix",
                "php",
                "printf",
                "python",
                "rasi",
                "regex",
                "svelte",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "astro", "php", "blade" },
        opts = {
            opts = {
                enable_cose = false,
            },
        },
    },
}

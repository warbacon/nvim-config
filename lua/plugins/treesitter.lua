return {
    "nvim-treesitter/nvim-treesitter",
    event = { "LazyFile", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "astro",
            "bash",
            "c",
            "cpp",
            "css",
            "diff",
            "dockerfile",
            "fish",
            "git_config",
            "gitcommit",
            "html",
            "hyprlang",
            "ini",
            "java",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "php",
            "powershell",
            "printf",
            "python",
            "rasi",
            "regex",
            "svelte",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.install").prefer_git = false
        require("nvim-treesitter.configs").setup(opts)
    end,
}

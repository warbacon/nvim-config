return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    main = "nvim-treesitter.configs",
    opts = {
        highlight = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "fish",
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
            "php",
            "powershell",
            "printf",
            "python",
            "rasi",
            "regex",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
    },
}

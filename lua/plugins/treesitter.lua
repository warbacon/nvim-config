return {
    "nvim-treesitter/nvim-treesitter",
    event = { "LazyFile", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
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
            "html",
            "hyprlang",
            "ini",
            "java",
            "javascript",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "powershell",
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
            "zathurarc",
        },
    },
    config = function(_, opts)
        vim.filetype.add({ pattern = { [".*/dunst/dunstrc"] = "dosini" } })
        require("nvim-treesitter.install").prefer_git = false
        require("nvim-treesitter.configs").setup(opts)
    end,
}

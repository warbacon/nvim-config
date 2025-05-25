return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
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
            },
        },
        config = function(_, opts)
            local installed_parsers = require("nvim-treesitter.config").installed_parsers()
            local to_install = vim.iter(opts.ensure_installed)
                :filter(function(parser)
                    return not vim.tbl_contains(installed_parsers, parser)
                end)
                :totable()
            require("nvim-treesitter").install(to_install)
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "LazyFile",
        opts = {
            opts = {
                enable_close = false,
            },
        },
    },
}

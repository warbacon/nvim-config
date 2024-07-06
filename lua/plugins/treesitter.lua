return {
    -- NVIM-TREESITTER =========================================================
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "LazyFile", "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        build = ":TSUpdate",
        init = function()
            vim.filetype.add({
                extension = { rasi = "rasi" },
                pattern = {
                    [".*/mako/config"] = "dosini",
                    [".*/hypr/.+%.conf"] = "hyprlang",
                    ["%.env%.[%w_.-]+"] = "sh",
                },
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
                "html",
                "hyprlang",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "printf",
                "python",
                "query",
                "rasi",
                "regex",
                "toml",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
            highlight = { enable = true },
            indent = { enable = true },
        },
    },

    -- NVIM-TREESITTER-TEXTOBJECTS =============================================
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        opts = {
            select = { enable = true },
        },
        config = function(_, opts)
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({ textobjects = opts })
        end,
    },
}

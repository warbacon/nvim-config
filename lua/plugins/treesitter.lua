return {
    -- TREESITTER ==============================================================
    {
        "nvim-treesitter/nvim-treesitter",
        main = "nvim-treesitter.configs",
        build = ":TSUpdate",
        opts = function()
            vim.filetype.add({
                extension = { rasi = "rasi" },
                pattern = {
                    ["%.env%.[%w_.-]+"] = "sh",
                    [".*/hypr/.+%.conf"] = "hyprlang",
                    [".*/mako/config"] = "dosini",
                    [".*/zathura/.+%.zathurarc"] = "zathurarc",
                },
            })

            require("nvim-treesitter.install").prefer_git = false

            return {
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "fish",
                    "git_config",
                    "html",
                    "hyprlang",
                    "ini",
                    "javascript",
                    "json",
                    "jsonc",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "powershell",
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
                    "zathurarc",
                },
            }
        end,
    },

    -- TS-AUTOTAG ==============================================================
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },

    -- TREESJ ==================================================================
    {
        "Wansmer/treesj",
        keys = {
            {
                "<leader>j",
                function()
                    require("treesj").join()
                end,
                mode = "n",
            },
            {
                "<leader>s",
                function()
                    require("treesj").split()
                end,
                mode = "n",
            },
        },
        opts = {
            use_default_keymaps = false,
        },
    },
}

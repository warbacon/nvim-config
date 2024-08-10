return {
    -- NVIM-TREESITTER =========================================================
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "File", "VeryLazy" },
        build = ":TSUpdate",
        init = function()
            vim.filetype.add({
                extension = { rasi = "rasi" },
                pattern = {
                    [".*/mako/config"] = "dosini",
                    [".*/hypr/.+%.conf"] = "hyprlang",
                    [".*/zathura/.+%.zathurarc"] = "zathurarc",
                    ["%.env%.[%w_.-]+"] = "sh",
                },
            })
        end,
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "astro",
                "typescript",
                "bash",
                "c",
                "cpp",
                "css",
                "diff",
                "fish",
                "git_config",
                "html",
                "hyprlang",
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
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-s>",
                    node_incremental = "<C-s>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
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

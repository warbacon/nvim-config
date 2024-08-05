return {
    -- NVIM-TREESITTER =========================================================
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "LazyFile", "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        build = ":TSUpdate",
        init = function(plugin)
            vim.filetype.add({
                extension = { rasi = "rasi" },
                pattern = {
                    [".*/mako/config"] = "dosini",
                    [".*/hypr/.+%.conf"] = "hyprlang",
                    [".*/zathura/.+%.zathurarc"] = "zathurarc",
                    ["%.env%.[%w_.-]+"] = "sh",
                },
            })
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
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

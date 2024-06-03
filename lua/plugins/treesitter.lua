return {
    -- NVIM-TREESITTER =========================================================
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "LazyFile", "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        init = function()
            -- Add hyprlang filetype
            if vim.fn.executable("Hyprland") == 1 then
                vim.filetype.add({
                    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
                })
            end
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
                "gitcommit",
                "html",
                "hyprlang",
                "json",
                "jsonc",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
    },

    -- NVIM-TREESITTER-TEXTOBJECTS =============================================
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        config = function()
            if require("util").is_loaded("nvim-treesitter") then
                require("nvim-treesitter.configs").setup({
                    textobjects = { select = { enable = true } },
                })
            end
        end,
    },
}

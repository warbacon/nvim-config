return {
    -- MINI.DIFF --------------------------------------------------------------
    {
        "echasnovski/mini.diff",
        event = "LazyFile",
        keys = {
            {
                "gho",
                function()
                    require("mini.diff").toggle_overlay(0)
                end,
                mode = "n",
            },
        },
        opts = {
            view = {
                style = "sign",
                signs = {
                    add = "▎",
                    change = "▎",
                    delete = "",
                },
            },
        },
    },

    -- MINI.SURROUND ----------------------------------------------------------
    {
        "echasnovski/mini.surround",
        keys = { { "s", mode = { "n", "v" } } },
        opts = {},
    },

    -- MINI.AI ----------------------------------------------------------------
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = {},
    },

    -- COMMENT.NVIM -----------------------------------------------------------
    {
        "numToStr/Comment.nvim",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                opts = { enable_autocmd = false },
            },
        },
        keys = {
            { "gc", mode = { "n", "v" } },
            { "gb", mode = "n" },
        },
        opts = function()
            return {
                mappings = { extra = false },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },

    -- NEOGIT -----------------------------------------------------------------
    {
        "NeogitOrg/neogit",
        cmd = { "Neogit", "NeogitResetState" },
        keys = {
            { "<leader>ng", "<cmd>Neogit<cr>", mode = "n" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {},
    },

    -- TELESCOPE.NVIM ---------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "telescope.nvim" } })
                return vim.ui.select(...)
            end
        end,
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                enabled = vim.fn.executable("make") == 1,
            },
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").find_files()
                end,
                mode = "n",
            },
            {
                "<leader>fh",
                function()
                    require("telescope.builtin").help_tags()
                end,
                mode = "n",
            },
            {
                "<leader>fg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                mode = "n",
            },
            {
                "<leader><leader>",
                function()
                    require("telescope.builtin").buffers()
                end,
                mode = "n",
            },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })
            pcall(require("telescope").load_extension, "fzf")
            require("telescope").load_extension("ui-select")
        end,
    },

    -- MARKDOWN-PREVIEW.NVIM --------------------------------------------------
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- VIM-KITTY --------------------------------------------------------------
    {
        "fladson/vim-kitty",
        enabled = os.getenv("TERM") == "xterm-kitty",
        ft = "kitty",
    },
}

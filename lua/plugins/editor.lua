return {
    -- GITSIGNS.NVIM ----------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        event = "LazyFile",
        opts = {},
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

    -- COMMENT.NVIM -----------------------------------------------------------
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "v" } },
            { "gb", mode = { "n", "v" } },
        },
        opts = { mappings = { extra = false } },
    },

    -- NVIM-HIGHLIGHT-COLORS --------------------------------------------------
    {
        "brenoprata10/nvim-highlight-colors",
        event = { "LazyFile" },
        opts = {
            render = "virtual",
            enable_named_colors = false,
        },
    },

    -- VIM-KITTY --------------------------------------------------------------
    {
        "fladson/vim-kitty",
        enabled = os.getenv("TERM") == "xterm-kitty",
        ft = "kitty",
    },

    -- TELESCOPE.NVIM ---------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-telescope/telescope-fzy-native.nvim",
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
            require("telescope").load_extension("fzy_native")
        end,
    },
}

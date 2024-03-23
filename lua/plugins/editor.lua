return {
    -- GITSIGNS.NVIM ----------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        event = "LazyFile",
        keys = {
            {
                "<leader>hp",
                function()
                    require("gitsigns").preview_hunk_inline()
                end,
                mode = "n",
            },
            {
                "<leader>hs",
                function()
                    require("gitsigns").stage_hunk()
                end,
                mode = "n",
            },
            {
                "<leader>hu",
                function()
                    require("gitsigns").undo_stage_hunk()
                end,
                mode = "n",
            },
            {
                "<leader>hr",
                function()
                    require("gitsigns").reset_hunk()
                end,
                mode = "n",
            },
        },
        init = function()
            vim.opt.signcolumn = "yes"
        end,
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
        },
    },

    -- NEOGIT -----------------------------------------------------------------
    {
        "NeogitOrg/neogit",
        cmd = { "Neogit", "NeogitResetState" },
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", mode = "n" },
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
            ---@diagnostic disable-next-line: duplicate-set-field
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
            pcall(require("telescope").load_extension, "ui-select")
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
            { "gb", mode = { "n", "v" } },
        },
        config = function()
            require("Comment").setup({
                mappings = { extra = false },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    -- NVIM-COLORIZER.LUA -----------------------------------------------------
    {
        "NvChad/nvim-colorizer.lua",
        event = "LazyFile",
        opts = {
            filetypes = {
                "*",
                "!lazy",
            },
            user_default_options = {
                names = false,
                mode = "virtualtext",
            },
        },
    },

    -- VIM-KITTY --------------------------------------------------------------
    {
        "fladson/vim-kitty",
        enabled = os.getenv("TERM") == "xterm-kitty",
        ft = "kitty",
    },
}

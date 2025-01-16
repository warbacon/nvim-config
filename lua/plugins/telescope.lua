return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = vim.fn.has("make") == 1 and "make",
        },
    },
    keys = {
        { "<leader>,", "<cmd>Telescope buffers<CR>" },
        { "<leader>f", "<cmd>Telescope find_files<CR>" },
        { "<leader>sg", "<cmd>Telescope live_grep<CR>" },
        { "<leader>sh", "<cmd>Telescope help_tags<CR>" },
        { "<leader>sd", "<cmd>Telescope diagnostics<CR>" },
        { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>" },
        { "<leader>sm", "<cmd>Telescope man_pages<CR>" },
    },
    opts = {
        defaults = {
            selection_caret = "  ",
            prompt_prefix = "❯ ",
            sorting_strategy = "ascending",
            layout_config = {
                prompt_position = "top",
            },
            file_ignore_patterns = {
                "%.class",
                "%.git",
                "%.o",
                "node_modules",
            },
        },
        pickers = {
            find_files = {
                hidden = true,
            },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        pcall(require("telescope").load_extension, "fzf")
    end,
}

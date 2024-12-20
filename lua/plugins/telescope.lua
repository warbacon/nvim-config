return {
    {
        "nvim-telescope/telescope.nvim",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "telescope.nvim" } })
                return vim.ui.select(...)
            end
        end,
        dependencies = {
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "natecraddock/telescope-zf-native.nvim" },
        },
        cmd = "Telescope",
        keys = {
            { "<leader>,", "<cmd>Telescope buffers<CR>" },
            { "<leader>f", "<cmd>Telescope find_files<CR>" },
            { "<leader>sg", "<cmd>Telescope live_grep<CR>" },
            { "<leader>sh", "<cmd>Telescope help_tags<CR>" },
            { "<leader>sd", "<cmd>Telescope diagnostics<CR>" },
            { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>" },
        },
        opts = function()
            return {
                defaults = {
                    selection_caret = "  ",
                    prompt_prefix = "   ",
                    path_display = { "filename_first" },
                    sorting_strategy = "ascending",
                    layout_config = {
                        prompt_position = "top",
                        height = 0.9,
                        width = 0.9,
                        preview_cutoff = 120,
                        preview_width = 0.6,
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
            }
        end,
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("zf-native")
        end,
    },
}

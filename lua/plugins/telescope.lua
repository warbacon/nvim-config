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
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
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
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
                defaults = {
                    selection_caret = "  ",
                    prompt_prefix = "   ",
                    path_display = { "filename_first" },
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            height = 0.95,
                            preview_cutoff = 100,
                            prompt_position = "top",
                            width = 0.95,
                        },
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
                        layout_config = {
                            horizontal = {
                                preview_width = 60,
                            },
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("ui-select")
            pcall(require("telescope").load_extension, "fzf")
        end,
    },
}

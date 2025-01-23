---@diagnostic disable: missing-fields
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        -- stylua: ignore start
        { "<leader>n", function() Snacks.notifier.show_history() end },
        { "<leader>,", function() Snacks.picker.buffers() end },
        { "<leader>f", function() Snacks.picker.files() end },
        { "<leader>sg", function() Snacks.picker.grep() end },
        { "<leader>sh", function() Snacks.picker.help() end },
        { "<leader>sd", function() Snacks.picker.diagnostics() end },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end },
        { "<leader>sm", function() Snacks.picker.man() end },
        -- stylua: ignore end
    },
    ---@type snacks.Config
    opts = {
        notifier = {},
        bigfile = {},
        quickfile = {},
        input = {},
        picker = {
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                    },
                },
                preview = {
                    wo = {
                        signcolumn = "no"
                    }
                },
            },
            layout = function()
                return {
                    preview = vim.o.columns >= 120 and true or false,
                    layout = {
                        box = "horizontal",
                        width = 0.8,
                        height = 0.8,
                        {
                            box = "vertical",
                            border = "rounded",
                            title = "{source} {live}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                        },
                        { win = "preview", border = "rounded", min_width = 60, width = 0.6 },
                    },
                }
            end,
            formatters = {
                file = {
                    filename_first = true,
                },
            },
            sources = {
                files = {
                    hidden = true,
                    exclude = {
                        "*.class",
                        "*.o",
                        ".git/",
                        "node_modules/",
                    },
                },
            },
            icons = {
                diagnostics = {
                    Error = util.icons.diagnostics.ERROR,
                    Warn = util.icons.diagnostics.WARN,
                    Hint = util.icons.diagnostics.HINT,
                    Info = util.icons.diagnostics.INFO,
                },
                kinds = util.icons.kinds,
            },
        },
    },
}

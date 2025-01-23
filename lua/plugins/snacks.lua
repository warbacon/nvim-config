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
        { "<leader>si", function() Snacks.picker.icons() end },
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
                        signcolumn = "no",
                    },
                },
            },
            layout = function()
                return {
                    preview = vim.o.columns >= 120 and true or false,
                    layout = require("snacks.picker.config.layouts").default.layout
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

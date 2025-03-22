return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        -- stylua: ignore start
        { "<leader>n",  function() Snacks.notifier.show_history() end },
        { "<leader>,",  function() Snacks.picker.buffers() end },
        { "<leader>f",  function() Snacks.picker.files() end },
        { "<leader>sg", function() Snacks.picker.grep() end },
        { "<leader>sh", function() Snacks.picker.help() end },
        { "<leader>sd", function() Snacks.picker.diagnostics() end },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end },
        { "<leader>sm", function() Snacks.picker.man() end },
        { "<leader>si", function() Snacks.picker.icons() end },
        { "<leader>sl", function() Snacks.picker.lazy() end },
        { "<leader>p",  function() Snacks.picker.pickers() end },
        -- stylua: ignore end
    },
    ---@type snacks.Config
    opts = {
        image = {
            enabled = vim.env.TERM == "xterm-kitty",
            doc = {
                inline = false,
            },
        },
        notifier = {},
        picker = {
            win = {
                preview = {
                    wo = { signcolumn = "no" },
                },
            },
            layout = function()
                return {
                    preview = vim.o.columns >= 120 and true or false,
                    layout = require("snacks.picker.config.layouts").default.layout,
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
                        "*.exe",
                        "*.o",
                        "*.a",
                        "*.so",
                        "*.dll",
                        "*.otf",
                        "*.ttf",
                        "*.woff*",
                        "*.log",
                        "node_modules/",
                        "vendor/",
                        ".git/",
                        "dist/",
                        "__pycache__/",
                    },
                },
            },
        },
    },
}

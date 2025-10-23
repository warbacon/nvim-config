return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- stylua: ignore
    keys = {
        { "<Leader>f", function() Snacks.picker.files() end },
        { "<Leader>,", function() Snacks.picker.buffers() end },
        { "<Leader>sd", function() Snacks.picker.diagnostics() end },
        { "<Leader>sg", function() Snacks.picker.grep() end },
        { "<Leader>sh", function() Snacks.picker.help() end },
        { "z=", function() Snacks.picker.spelling() end },
    },
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                    },
                },
                preview = {
                    wo = { signcolumn = "no" },
                },
            },
            layout = function()
                return {
                    preview = vim.o.columns >= 120 and true or false,
                    layout = {
                        min_width = 0,
                    },
                    preset = "default",
                }
            end,
            sources = {
                files = {
                    hidden = true,
                    exclude = {
                        "*.class",
                        "*.exe",
                        "*.a",
                        "*.o",
                        "*.otf",
                        "*.ttf",
                        "*.woff*",
                        "*.pdf",
                        "node_modules/",
                        "vendor/",
                    },
                },
            },
            icons = {
                diagnostics = {
                    Error = Util.icons.signs[1],
                    Warn = Util.icons.signs[2],
                    Info = Util.icons.signs[3],
                    Hint = Util.icons.signs[4],
                },
                kinds = Util.icons.kinds,
            },
        },
        image = {
            enabled = vim.fn.has("win32") == 0,
            doc = {
                inline = false,
                max_width = 60,
                max_height = 20,
            },
            convert = {
                notify = false,
            },
            math = {
                enabled = false,
            },
        },
        notifier = { enabled = true },
    },
}

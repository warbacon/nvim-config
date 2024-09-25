return {
    -- CONFORM =================================================================
    {
        "stevearc/conform.nvim",
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ lsp_fallback = true })
                end,
            },
        },
        opts = {
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                fish = { "fish_indent" },
                lua = { "stylua" },
                markdown = { "markdownlint-cli2", "injected" },
                python = { "ruff_format" },
                sh = { "shfmt" },
                ["_"] = { "trim_whitespace" },
            },
            formatters = {
                clang_format = {
                    prepend_args = {
                        "-style={IndentWidth: 4, BreakBeforeBraces: Linux, AccessModifierOffset: -4, ColumnLimit: 100}",
                    },
                },
                shfmt = { prepend_args = { "-i", "4", "-ci", "-bn" } },
            },
        },
    },
}

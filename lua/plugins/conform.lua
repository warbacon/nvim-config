return {
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
            css = { "prettierd" },
            fish = { "fish_indent" },
            html = { "prettierd" },
            javascript = { "prettierd" },
            json = { "prettierd" },
            lua = { "stylua" },
            markdown = { "prettierd", "injected" },
            python = { "ruff_format" },
            sh = { "shfmt" },
            typescript = { "prettierd" },
            yaml = { "prettierd" },
            ["_"] = { "trim_whitespace", "trim_newlines" },
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
}

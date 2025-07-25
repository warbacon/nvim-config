return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format()
            end,
        },
    },
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            c = { "clang-format" },
            cpp = { "clang-format" },
            fish = { "fish_indent" },
            lua = { "stylua" },
            sh = { "shfmt" },
            ["*"] = { "injected" },
            ["_"] = { "trim_whitespace", "trim_newlines", lsp_format = "prefer" },
        },
        formatters = {
            shfmt = {
                append_args = { "-i=4", "-ci", "-bn" },
            },
            ["clang-format"] = {
                append_args = {
                    "-style={IndentWidth: 4, BreakBeforeBraces: Linux, AccessModifierOffset: -4, ColumnLimit: 100}",
                },
            },
        },
    },
}

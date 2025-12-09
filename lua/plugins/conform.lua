return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        format_on_save = {
            format_on_save = {
                lsp_format = "fallback",
                timeout_ms = 500,
            },
        },
        formatters_by_ft = {
            c = { "clang-format" },
            cpp = { "clang-format" },
            fish = { "fish_indent" },
            lua = { "stylua" },
            sh = { "shfmt" },
            toml = { "taplo" },
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

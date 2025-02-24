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
    opts = {
        formatters_by_ft = {
            fish = { "fish_indent" },
            lua = { "stylua" },
            ["*"] = { "injected" },
            ["_"] = { "trim_whitespace", "trim_newlines" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}

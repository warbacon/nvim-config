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
            fish = { "fish_indent" },
            lua = { "stylua" },
            ft = { "nixfmt" },
            ["*"] = { "injected" },
            ["_"] = { "trim_whitespace", "trim_newlines", lsp_format = "prefer" },
        },
    },
}

return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "mason.nvim",
    },
    ft = { "fish", "markdown" },
    opts = function()
        local null_ls = require("null-ls")

        return {
            sources = {
                null_ls.builtins.diagnostics.fish,
                null_ls.builtins.diagnostics.markdownlint.with({
                    extra_args = { "--disable", "MD033" },
                }),
            },
        }
    end,
}

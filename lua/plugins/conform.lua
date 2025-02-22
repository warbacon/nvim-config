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
            lua = { "stylua" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}

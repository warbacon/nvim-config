---@diagnostic disable: missing-fields
return {
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        ---@module "bqf"
        ---@type BqfConfig
        opts = {
            preview = { winblend = 0 },
        },
    },
    {
        "stevearc/quicker.nvim",
        keys = {
            {
                "<leader>q",
                function()
                    require("quicker").toggle({ focus = true })
                end,
            },
        },
        ft = "qf",
        ---@type quicker.SetupOptions
        opts = {
            type_icons = {
                E = Util.icons.diagnostics.ERROR,
                W = Util.icons.diagnostics.WARN,
                I = Util.icons.diagnostics.INFO,
                N = Util.icons.diagnostics.INFO,
                H = Util.icons.diagnostics.INFO,
            },
        },
    },
}

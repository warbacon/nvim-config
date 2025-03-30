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
                E = vim.diagnostic.config().signs.text["ERROR"],
                W = vim.diagnostic.config().signs.text["WARN"],
                I = vim.diagnostic.config().signs.text["INFO"],
                N = vim.diagnostic.config().signs.text["INFO"],
                H = vim.diagnostic.config().signs.text["HINT"],
            },
        },
    },
}

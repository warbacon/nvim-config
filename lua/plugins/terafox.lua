return {
    "EdenEast/nightfox.nvim",
    name = "terafox",
    priority = 1000,
    opts = {
        groups = {
            all = {
                ["@markup.raw"] = { fg = "palette.cyan", bg = "palette.bg3", style = "" },
            },
        },
    },
    config = function(_, opts)
        require("nightfox").setup(opts)
        vim.cmd.colorscheme("terafox")
    end,
}

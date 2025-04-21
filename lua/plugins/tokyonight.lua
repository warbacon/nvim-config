return {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
        plugins = {
            ["indent-blankline"] = true,
        },
    },
    config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd.colorscheme("tokyonight-night")
    end,
}

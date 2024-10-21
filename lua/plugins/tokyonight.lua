return {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
        on_highlights = function(highlights, colors)
            highlights.CursorInsert = { bg = colors.green }
        end,
    },
    config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd.colorscheme("tokyonight")
    end,
}

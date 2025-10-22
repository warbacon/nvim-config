return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("tokyonight").setup({
            on_highlights = function(hl, c)
                hl.PmenuBorder = { link = "FloatBorder" }
                hl.MatchParen = {
                    bg = c.fg_gutter,
                    bold = true,
                }
            end,
        })

        vim.cmd.colorscheme("tokyonight-night")
    end,
}

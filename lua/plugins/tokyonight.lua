return {
    "folke/tokyonight.nvim",
    priority = 1000,
    ---@module "tokyonight"
    ---@type tokyonight.Config
    opts = {
        on_highlights = function(hl, c)
            hl.PmenuBorder = { link = "FloatBorder" }
            hl.BlinkIndentScope = { fg = hl.FloatBorder.fg }
            hl.MatchParen = {
                bg = c.fg_gutter,
                bold = true,
            }
        end,
    },
    config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd.colorscheme("tokyonight-night")
    end,
}

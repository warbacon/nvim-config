local M = {}

M.load = function()
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end
    vim.g.colors_name = "pino"

    local colors = require("pino.colors").setup()
    local groups = require("pino.groups").setup(colors)

    for group, hl in pairs(groups) do
        vim.api.nvim_set_hl(0, group, hl)
    end

    vim.g.terminal_color_0 = colors.overlay
    vim.g.terminal_color_1 = colors.love
    vim.g.terminal_color_2 = colors.leaf
    vim.g.terminal_color_3 = colors.gold
    vim.g.terminal_color_4 = colors.pine
    vim.g.terminal_color_5 = colors.iris
    vim.g.terminal_color_6 = colors.foam
    vim.g.terminal_color_7 = colors.subtle
    vim.g.terminal_color_8 = colors.muted
    vim.g.terminal_color_9 = colors.love
    vim.g.terminal_color_10 = colors.leaf
    vim.g.terminal_color_11 = colors.gold
    vim.g.terminal_color_12 = colors.pine
    vim.g.terminal_color_13 = colors.iris
    vim.g.terminal_color_14 = colors.foam
    vim.g.terminal_color_15 = colors.text
end

M.setup = require("pino.config").setup

return M

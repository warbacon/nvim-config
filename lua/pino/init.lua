local M = {}

M.init = function()
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.g.colors_name = "pino"

    local colors = require("pino.colors")
    for group, hl in pairs(colors) do
        vim.api.nvim_set_hl(0, group, hl)
    end

    local palette = require("pino.palette")

    vim.g.terminal_color_0 = palette.overlay -- Black
    vim.g.terminal_color_1 = palette.love -- Red
    vim.g.terminal_color_2 = palette.leaf -- Green
    vim.g.terminal_color_3 = palette.gold -- Yellow
    vim.g.terminal_color_4 = palette.pine -- Blue
    vim.g.terminal_color_5 = palette.iris -- Magenta
    vim.g.terminal_color_6 = palette.foam -- Cyan
    vim.g.terminal_color_7 = palette.subtle -- White

    vim.g.terminal_color_8 = palette.muted -- Bright Black
    vim.g.terminal_color_9 = palette.love -- Bright Red
    vim.g.terminal_color_10 = palette.leaf -- Bright Green
    vim.g.terminal_color_11 = palette.gold -- Bright Yellow
    vim.g.terminal_color_12 = palette.pine -- Bright Blue
    vim.g.terminal_color_13 = palette.iris -- Bright Magenta
    vim.g.terminal_color_14 = palette.foam -- Bright Cyan
    vim.g.terminal_color_15 = palette.text -- Bright White
end

return M

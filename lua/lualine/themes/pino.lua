local colors = require("pino.colors").setup()

return {
    normal = {
        a = { bg = colors.pine, fg = colors.base, gui = "bold" },
        b = { bg = colors.highlight, fg = colors.pine },
        c = { bg = colors.surface, fg = colors.subtle },
    },
    insert = {
        a = { bg = colors.leaf, fg = colors.base, gui = "bold" },
        b = { bg = colors.highlight, fg = colors.leaf },
    },
    terminal = {
        a = { bg = colors.leaf, fg = colors.base, gui = "bold" },
        b = { bg = colors.highlight, fg = colors.leaf },
    },
    command = {
        a = { bg = colors.gold, fg = colors.base, gui = "bold" },
        b = { bg = colors.highlight, fg = colors.gold },
    },
    replace = {
        a = { bg = colors.love, fg = colors.base, gui = "bold" },
        b = { bg = colors.highlight, fg = colors.love },
    },
    visual = {
        a = { bg = colors.iris, fg = colors.base, gui = "bold" },
        b = { bg = colors.highlight, fg = colors.iris },
    },
    inactive = {
        a = { bg = colors.muted, fg = colors.base, gui = "bold" },
        b = { bg = colors.overlay, fg = colors.muted },
        c = { fg = colors.muted, bg = colors.surface },
    },
}

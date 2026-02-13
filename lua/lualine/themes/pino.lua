local palette = require("pino.palette")

return {
    normal = {
        a = { bg = palette.pine, fg = palette.base, gui = "bold" },
        b = { bg = palette.highlight, fg = palette.pine },
        c = { bg = palette.surface, fg = palette.subtle },
    },
    insert = {
        a = { bg = palette.leaf, fg = palette.base, gui = "bold" },
        b = { bg = palette.highlight, fg = palette.leaf },
    },
    terminal = {
        a = { bg = palette.leaf, fg = palette.base, gui = "bold" },
        b = { bg = palette.highlight, fg = palette.leaf },
    },
    command = {
        a = { bg = palette.gold, fg = palette.base, gui = "bold" },
        b = { bg = palette.highlight, fg = palette.gold },
    },
    replace = {
        a = { bg = palette.love, fg = palette.base, gui = "bold" },
        b = { bg = palette.highlight, fg = palette.love },
    },
    visual = {
        a = { bg = palette.iris, fg = palette.base, gui = "bold" },
        b = { bg = palette.highlight, fg = palette.iris },
    },
    inactive = {
        a = { bg = palette.muted, fg = palette.base, gui = "bold" },
        b = { bg = palette.overlay, fg = palette.muted },
        c = { fg = palette.muted, bg = palette.surface },
    },
}

local M = {}

--- @param colors table
function M.generate(colors)
    local content = require("pino.util").template(
        [[
[colors.primary]
background = "${base}"
foreground = "${text}"
dim_foreground = "${muted}"

[colors.search.matches]
foreground = "${base}"
background = "${gold}"

[colors.search.focused_match]
foreground = "${base}"
background = "${mango}"

[colors.hints.start]
foreground = "${base}"
background = "${gold}"

[colors.hints.end]
foreground = "${base}"
background = "${pine}"

[colors.footer_bar]
foreground = "${text}"
background = "${surface}"

[colors.selection]
text = "CellForeground"
background = "${selection}"

[colors.normal]
black = "${overlay}"
red = "${love}"
green = "${leaf}"
yellow = "${gold}"
blue = "${pine}"
magenta = "${iris}"
cyan = "${foam}"
white = "${subtle}"

[colors.bright]
black = "${muted}"
red = "${bright_love}"
green = "${bright_leaf}"
yellow = "${bright_gold}"
blue = "${bright_pine}"
magenta = "${bright_iris}"
cyan = "${bright_foam}"
white = "${text}"
]],
        colors
    )

    return {
        { filename = "pino.toml", content = content },
    }
end

return M

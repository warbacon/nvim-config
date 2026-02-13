local util = require("pino.utils")

local M = {}

--- @param palette table
function M.generate(palette)
    local content = util.template(
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
background = "${surface}"

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
red = "${love}"
green = "${leaf}"
yellow = "${gold}"
blue = "${pine}"
magenta = "${iris}"
cyan = "${foam}"
white = "${text}"
]],
        palette
    )

    return {
        { filename = "pino.toml", content = content },
    }
end

return M

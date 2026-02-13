local util = require("pino.utils")

local M = {}

--- @param palette table
function M.generate(palette)
    local colorscheme = util.template(
        [[
{
    "name": "Pino",
    "background": "${base}",
    "foreground": "${text}",
    "cursorColor": "${text}",
    "selectionBackground": "${surface}",
    "black": "${overlay}",
    "red": "${love}",
    "green": "${leaf}",
    "yellow": "${gold}",
    "blue": "${pine}",
    "purple": "${iris}",
    "cyan": "${foam}",
    "white": "${subtle}",
    "brightBlack": "${muted}",
    "brightRed": "${love}",
    "brightGreen": "${leaf}",
    "brightYellow": "${gold}",
    "brightBlue": "${pine}",
    "brightPurple": "${iris}",
    "brightCyan": "${foam}",
    "brightWhite": "${text}"
}
]],
        palette
    )
    return {
        { filename = "pino-colorscheme.json", content = colorscheme },
    }
end

return M

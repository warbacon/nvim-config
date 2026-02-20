local M = {}

--- @param colors table
function M.generate(colors)
    local content = require("pino.util").template(
        [[
{
    "name": "Pino",
    "background": "${base}",
    "foreground": "${text}",
    "cursorColor": "${text}",
    "selectionBackground": "${selection}",
    "black": "${overlay}",
    "red": "${love}",
    "green": "${leaf}",
    "yellow": "${gold}",
    "blue": "${pine}",
    "purple": "${iris}",
    "cyan": "${foam}",
    "white": "${subtle}",
    "brightBlack": "${muted}",
    "brightRed": "${bright_love}",
    "brightGreen": "${bright_leaf}",
    "brightYellow": "${bright_gold}",
    "brightBlue": "${bright_pine}",
    "brightPurple": "${bright_iris}",
    "brightCyan": "${bright_foam}",
    "brightWhite": "${text}"
}
]],
        colors
    )
    return {
        { filename = "pino-colorscheme.json", content = content },
    }
end

return M

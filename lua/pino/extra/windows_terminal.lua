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
    "selectionBackground": "${overlay}",
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
        colors
    )
    return {
        { filename = "pino-colorscheme.json", content = content },
    }
end

return M

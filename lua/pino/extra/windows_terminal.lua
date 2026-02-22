local M = {}

--- @param colors table
function M.generate(colors)
    local colorscheme = require("pino.util").template(
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

    local theme = require("pino.util").template(
        [[
{
    "name": "Pino",
    "tab": {
        "background": "terminalBackground",
        "unfocusedBackground": "#00000000"
    },
    "tabRow": {
        "background": "${crust}",
        "unfocusedBackground": "${overlay}"
    },
    "window": {
        "frame": "${pine}",
        "unfocusedFrame": "${highlight}"
    }
},
]],
        colors
    )

    return {
        { filename = "pino-colorscheme.json", content = colorscheme },
        { filename = "pino-theme.json", content = theme },
    }
end

return M

local M = {}

--- @param colors table
function M.generate(colors)
    local content = require("pino.util").template(
        [[
foreground ${text}
background ${base}
selection_foreground none
selection_background ${selection}
cursor ${text}
cursor_text_color ${base}

# Black
color0 ${overlay}
color8 ${muted}

# Red
color1 ${love}
color9 ${bright_love}

# Green
color2 ${leaf}
color10 ${bright_leaf}

# Yellow
color3 ${gold}
color11 ${bright_gold}

# Blue
color4 ${pine}
color12 ${bright_pine}

# Magenta
color5 ${iris}
color13 ${bright_iris}

# Cyan
color6 ${foam}
color14 ${bright_foam}

# White
color7 ${subtle}
color15 ${text}
]],
        colors
    )

    return {
        { filename = "pino.conf", content = content },
    }
end

return M

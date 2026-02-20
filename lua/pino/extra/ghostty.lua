local M = {}

--- @param colors table
function M.generate(colors)
    local content = require("pino.util").template(
        [[
background = ${base}
foreground = ${text}
cursor-color = ${text}
cursor-text = ${base}
selection-background = ${selection}
selection-foreground = cell-foreground

# Black
palette = 0=${overlay}
palette = 8=${muted}

# Red
palette = 1=${love}
palette = 9=${bright_love}

# Green
palette = 2=${leaf}
palette = 10=${bright_leaf}

# Yellow
palette = 3=${gold}
palette = 11=${bright_gold}

# Blue
palette = 4=${pine}
palette = 12=${bright_pine}

# Magenta
palette = 5=${iris}
palette = 13=${bright_iris}

# Cyan
palette = 6=${foam}
palette = 14=${bright_foam}

# White
palette = 7=${subtle}
palette = 15=${text}
]],
        colors
    )

    return {
        { filename = "pino", content = content },
    }
end

return M

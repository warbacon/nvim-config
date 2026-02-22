local M = {}

--- @param colors table
function M.generate(colors)
    -- Foot doesn't support hex colors with #, so we need to remove it
    local foot_colors = {}
    for k, v in pairs(colors) do
        foot_colors[k] = v:sub(2)
    end

    local content = require("pino.util").template(
        [[
[colors]
foreground=${text}
background=${base}
selection-background=${selection}

# Black
regular0=${overlay}
bright0=${muted}

# Red
regular1=${love}
bright1=${bright_love}

# Green
regular2=${leaf}
bright2=${bright_leaf}

# Yellow
regular3=${gold}
bright3=${bright_gold}

# Blue
regular4=${pine}
bright4=${bright_pine}

# Magenta
regular5=${iris}
bright5=${bright_iris}

# Cyan
regular6=${foam}
bright6=${bright_foam}

# White
regular7=${subtle}
bright7=${text}
]],
        foot_colors
    )

    return {
        { filename = "pino.ini", content = content },
    }
end

return M

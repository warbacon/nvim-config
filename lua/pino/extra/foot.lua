local M = {}

--- @param colors table
function M.generate(colors)
    -- Foot doesn't support hex colors with #, so we need to remove it
    local foot_colors = {}
    for k, v in pairs(colors) do
        if type(v) == "string" and v:match("^#") then
            foot_colors[k] = v:sub(2)
        else
            foot_colors[k] = v
        end
    end

    local content = require("pino.util").template(
        [[
[colors]
foreground=${text}
background=${base}
selection-background=${selection}

## Normal/regular colors (color palette 0-7)
regular0=${overlay}  # black
regular1=${love}     # red
regular2=${leaf}     # green
regular3=${gold}     # yellow
regular4=${pine}     # blue
regular5=${iris}     # magenta
regular6=${foam}     # cyan
regular7=${subtle}   # white

## Bright colors (color palette 8-15)
bright0=${muted}         # bright black
bright1=${bright_love}   # bright red
bright2=${bright_leaf}   # bright green
bright3=${bright_gold}   # bright yellow
bright4=${bright_pine}   # bright blue
bright5=${bright_iris}   # bright magenta
bright6=${bright_foam}   # bright cyan
bright7=${text}          # bright white
]],
        foot_colors
    )

    return {
        { filename = "pino.ini", content = content },
    }
end

return M

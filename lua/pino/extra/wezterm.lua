local M = {}

--- @param colors table
function M.generate(colors)
    local content = require("pino.util").template(
        [[
[colors]
foreground = "${text}"
background = "${base}"
cursor_fg = "${base}"
cursor_bg = "${text}"
cursor_border = "${text}"
selection_fg = "none"
selection_bg = "${selection}"
scrollbar_thumb = "${muted}"
split = "${overlay}"

ansi = [
    "${overlay}",
    "${love}",
    "${leaf}",
    "${gold}",
    "${pine}",
    "${iris}",
    "${foam}",
    "${subtle}",
]

brights = [
    "${muted}",
    "${bright_love}",
    "${bright_leaf}",
    "${bright_gold}",
    "${bright_pine}",
    "${bright_iris}",
    "${bright_foam}",
    "${text}",
]

[colors.tab_bar]
background = "${base}"
inactive_tab_edge = "${base}"

[colors.tab_bar.active_tab]
bg_color = "${pine}"
fg_color = "${base}"
intensity = "Bold"

[colors.tab_bar.inactive_tab]
bg_color = "${overlay}"
fg_color = "${muted}"

[colors.tab_bar.inactive_tab_hover]
bg_color = "${highlight}"
fg_color = "${subtle}"

[colors.tab_bar.new_tab]
bg_color = "${overlay}"
fg_color = "${muted}"

[colors.tab_bar.new_tab_hover]
bg_color = "${highlight}"
fg_color = "${text}"
]],
        colors
    )

    return {
        { filename = "pino.toml", content = content },
    }
end

return M

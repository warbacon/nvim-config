local M = {}

---@return table<string,string>
M.setup = function()
    local opts = require("pino.config").options
    local utils = require("pino.util")

    local colors = {
        base = "21.35% 0.025 291",
        surface = "25.35% 0.035 291",
        overlay = "29.35% 0.044 291",
        highlight = "33.35% 0.052 291",
        text = "85% 0.035 291",
        subtle = "70% 0.053 291",
        muted = "55% 0.055 291",
        gold = "84.29% 0.11 77",
        bright_gold = "90.29% 0.11 77",
        mango = "85% 0.15 45",
        pine = "70% 0.0926 228",
        bright_pine = "76% 0.0926 228",
        foam = "82.19% 0.0543 209.56",
        bright_foam = "88.19% 0.0543 209.56",
        iris = "77.6% 0.0945 304.99",
        bright_iris = "83.6% 0.0945 304.99",
        love = "69.77% 0.1565 4.22",
        bright_love = "75.77% 0.1565 4.22",
        rose = "83.63% 0.0544 21.14",
        leaf = "77.66% 0.0952 141.53",
        bright_leaf = "83.66% 0.0952 141.53",
    }

    colors = utils.convert_colors(colors)
    colors.selection = "#263446"
    opts.on_colors(colors)

    return colors
end

return M

local M = {}

--- @param colors table
function M.generate(colors)
    local content = require("pino.util").template(
        [[
gui:
  spinner:
    rate: 80
    frames:
    - "⠋"
    - "⠙"
    - "⠹"
    - "⠸"
    - "⠼"
    - "⠴"
    - "⠦"
    - "⠧"
    - "⠇"
    - "⠏"
  theme:
    activeBorderColor:
      - "${pine}"
      - "bold"
    inactiveBorderColor:
      - "${muted}"
    selectedLineBgColor:
      - "${selection}"
    defaultFgColor:
      - "${text}"
]],
        colors
    )

    return {
        { filename = "lazygit.yaml", content = content },
    }
end

return M

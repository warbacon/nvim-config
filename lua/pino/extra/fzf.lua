local M = {}

--- @param colors table
function M.generate(colors)
    local fzf_default_opts = require("pino.util").template(
        [[
"$FZF_DEFAULT_OPTS \
    --highlight-line \
    --color=fg:${text} \
    --color=bg:${base} \
    --color=gutter:${base} \
    --color=border:${pine} \
    --color=separator:${pine} \
    --color=scrollbar:${muted} \
    --color=hl:${love} \
    --color=hl+:${love} \
    --color=fg+:${text} \
    --color=bg+:${selection} \
    --color=pointer:${rose} \
    --color=prompt:${rose} \
    --color=spinner:${rose} \
    --color=marker:${rose} \
    --color=header:${pine} \
    --color=info:${muted} \
    --color=preview-border:${pine} \
    --color=preview-scrollbar:${muted}"
]],
        colors
    )

    return {
        {
            filename = "fzf-pino.sh",
            content = "export FZF_DEFAULT_OPTS=" .. fzf_default_opts,
        },
    }
end

return M

return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
        completions = {
            lsp = { enabled = true },
        },
        heading = {
            sign = false,
        },
        code = {
            sign = false,
        },
        overrides = {
            buftype = {
                nofile = {
                    code = {
                        language = false,
                        border = "none",
                    },
                },
            },
        },
    },
}

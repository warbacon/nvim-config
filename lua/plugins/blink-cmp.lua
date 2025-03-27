return {
    "saghen/blink.cmp",
    version = "*",
    event = { "LazyFile", "InsertEnter", "VeryLazy" },
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        cmdline = { enabled = false },
        signature = { enabled = true },
        appearance = {
            nerd_font_variant = "normal",
            kind_icons = Util.icons.kinds,
        },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
    },
}

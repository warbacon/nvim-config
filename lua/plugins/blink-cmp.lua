return {
    "Saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
        keymap = {
            ["<C-s>"] = { "hide", "fallback" },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            cmdline = {},
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
        appearance = {
            nerd_font_variant = "normal",
            kind_icons = util.icons.kinds,
        },
    },
}

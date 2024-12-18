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
            completion = {
                enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
            },
            providers = {
                lsp = { fallback_for = { "lazydev" } },
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
            },
        },
        appearance = {
            nerd_font_variant = "normal",
            kind_icons = util.icons.kinds,
        },
    },
}

return {
    "Saghen/blink.cmp",
    version = "*",
    opts = {
        keymap = {
            preset = "enter",
            ["<C-s>"] = { "hide", "fallback" },
        },
        completion = {
            trigger = {
                show_on_blocked_trigger_characters = { " ", "\n", "\t", "{" },
            },
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            documentation = {
                auto_show = true,
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
            kind_icons = Util.icons.kinds,
        },
    },
}

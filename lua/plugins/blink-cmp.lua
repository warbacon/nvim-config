return {
    "Saghen/blink.cmp",
    version = "v0.7.4",
    event = "InsertEnter",
    opts = {
        keymap = {
            preset = "enter",
            ["<C-s>"] = { "hide", "fallback" },
        },
        completion = {
            trigger = {
                show_on_blocked_trigger_characters = { " ", "\n", "\t", "{" },
            },
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
            kind_icons = Util.icons.kinds,
        },
    },
}

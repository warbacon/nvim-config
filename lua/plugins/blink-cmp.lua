return {
    "Saghen/blink.cmp",
    version = "*",
    enabled = false,
    event = "InsertEnter",
    opts = {
        keymap = {
            preset = "enter",
            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },
        },
        accept = {
            -- auto_brackets = { enabled = true }
        },
        nerd_font_variant = "normal",
        windows = {
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
        trigger = {
            completion = {
                blocked_trigger_characters = { " ", "\n", "\t", "{" },
            },
        },
        kind_icons = require("util.icons").kinds,
    },
}

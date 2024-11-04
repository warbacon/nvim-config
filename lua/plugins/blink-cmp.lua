return {
    "Saghen/blink.cmp",
    version = "*",
    enabled = false,
    opts = {
        keymap = {
            preset = "enter",
            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },
        },
        -- accept = { auto_brackets = { enabled = true } },
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
        kind_icons = require("util.icons").kinds,
    },
}

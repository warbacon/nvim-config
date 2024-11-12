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
        fuzzy = {
            use_frecency = false,
        },
        trigger = {
            completion = {
                show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
            },
        },
        kind_icons = require("util.icons").kinds,
    },
}

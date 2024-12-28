return {
    "Saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            ["<C-s>"] = { "hide", "fallback" },
        },
        completion = {
            accept = {
                auto_brackets = { enabled = false },
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
            kind_icons = util.icons.kinds
        },
    },
}

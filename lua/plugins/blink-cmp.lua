return {
    "Saghen/blink.cmp",
    version = "1.*",
    ---@module "blink-cmp"
    ---@type blink.cmp.Config
    opts = {
        cmdline = { enabled = false },
        appearance = {
            kind_icons = Util.icons.kinds,
            nerd_font_variant = "normal",
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        sources = {
            per_filetype = {
                lua = { inherit_defaults = true, "lazydev" },
            },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
                path = {
                    opts = {
                        show_hidden_files_by_default = true,
                    },
                },
            },
        },
    },
}

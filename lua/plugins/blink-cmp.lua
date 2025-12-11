return {
    "Saghen/blink.cmp",
    version = "1.*",
    ---@module "blink-cmp"
    ---@type blink.cmp.Config
    opts = {
        cmdline = {
            completion = {
                list = {
                    selection = {
                        preselect = false,
                    },
                },
                menu = {
                    auto_show = true,
                },
            },
        },
        appearance = {
            kind_icons = Util.icons.kinds,
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
            menu = {
                draw = {
                    gap = 2,
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 2 },
                    },
                },
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

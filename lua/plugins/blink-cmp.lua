return {
    "saghen/blink.cmp",
    version = "*",
    event = { "LazyFile", "InsertEnter", "VeryLazy" },
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        cmdline = { enabled = false },
        signature = { enabled = true },
        appearance = {
            nerd_font_variant = "normal",
            kind_icons = Util.icons.kinds,
        },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            menu = {
                draw = {
                    components = {
                        -- customize the drawing of kind icons
                        kind_icon = {
                            text = function(ctx)
                                -- default kind icon
                                local icon = ctx.kind_icon
                                -- if LSP source, check for color derived from documentation
                                if ctx.item.source_name == "LSP" then
                                    local color_item = require("nvim-highlight-colors").format(
                                        ctx.item.documentation,
                                        { kind = ctx.kind }
                                    )
                                    if color_item and color_item.abbr ~= "" then
                                        icon = color_item.abbr
                                    end
                                end
                                return icon .. ctx.icon_gap
                            end,
                            highlight = function(ctx)
                                -- default highlight group
                                local highlight = "BlinkCmpKind" .. ctx.kind
                                -- if LSP source, check for color derived from documentation
                                if ctx.item.source_name == "LSP" then
                                    local color_item = require("nvim-highlight-colors").format(
                                        ctx.item.documentation,
                                        { kind = ctx.kind }
                                    )
                                    if color_item and color_item.abbr_hl_group then
                                        highlight = color_item.abbr_hl_group
                                    end
                                end
                                return highlight
                            end,
                        },
                    },
                },
            },
        },
    },
}

return {
    "saghen/blink.cmp",
    version = "1.*",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        cmdline = { enabled = false },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },
        appearance = {
            nerd_font_variant = "normal",
            kind_icons = Util.icons.kinds,
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
                lsp = {
                    fallbacks = { "path", "buffer" },
                },
                path = {
                    opts = {
                        show_hidden_files_by_default = true,
                    },
                },
                buffer = {
                    -- keep case of first char
                    transform_items = function(a, items)
                        local keyword = a.get_keyword()
                        local correct, case
                        if keyword:match("^%l") then
                            correct = "^%u%l+$"
                            case = string.lower
                        elseif keyword:match("^%u") then
                            correct = "^%l+$"
                            case = string.upper
                        else
                            return items
                        end

                        -- avoid duplicates from the corrections
                        local seen = {}
                        local out = {}
                        for _, item in ipairs(items) do
                            local raw = item.insertText
                            if raw and raw:match(correct) then
                                local text = case(raw:sub(1, 1)) .. raw:sub(2)
                                item.insertText = text
                                item.label = text
                            end
                            if not seen[item.insertText] then
                                seen[item.insertText] = true
                                table.insert(out, item)
                            end
                        end
                        return out
                    end,
                },
            },
        },
    },
}

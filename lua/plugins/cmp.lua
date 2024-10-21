return {
    -- LUASNIP =================================================================
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        build = (function()
            if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                return
            end
            return "make install_jsregexp"
        end)(),
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },

    -- CMP =====================================================================
    {
        "iguanacucumber/magazine.nvim",
        name = "nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, item)
                        local kinds = require("util.icons").kinds

                        if kinds[item.kind] then
                            item.kind = kinds[item.kind]
                        end

                        local entryItem = entry:get_completion_item()
                        local color = entryItem.documentation

                        if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
                            local hl = "hex-" .. color:sub(2)

                            if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
                                vim.api.nvim_set_hl(0, hl, { fg = color })
                            end

                            item.menu = " "
                            item.menu_hl_group = hl
                        end

                        local widths = { abbr = 40, menu = 30 }

                        for key, width in pairs(widths) do
                            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                            end
                        end

                        return item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                    ["<C-l>"] = cmp.mapping(function()
                        if require("luasnip").expand_or_locally_jumpable() then
                            require("luasnip").expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if require("luasnip").locally_jumpable(-1) then
                            require("luasnip").jump(-1)
                        end
                    end, { "i", "s" }),
                }),
                view = {
                    entries = { follow_cursor = true },
                },
                sources = cmp.config.sources({
                    { name = "lazydev", group_index = 0 },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            }
        end,
    },
}

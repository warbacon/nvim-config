return {
    -- SNIPPY ==================================================================
    {
        "dcampos/nvim-snippy",
        lazy = true,
        opts = {
            mappings = {
                is = {
                    ["<C-l>"] = "expand_or_advance",
                    ["<C-h>"] = "previous",
                },
            },
        },
    },

    -- CMP =====================================================================
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "dcampos/cmp-snippy",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                snippet = {
                    expand = function(args)
                        require("snippy").expand_snippet(args.body)
                    end,
                },
                completion = { completeopt = "menuone" },
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
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = function(fallback)
                        if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
                            if cmp.confirm({ select = true }) then
                                return
                            end
                        end
                        fallback()
                    end,
                    ["<S-CR>"] = function(fallback)
                        if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
                            if cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }) then
                                return
                            end
                        end
                        fallback()
                    end,
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                }),
                sources = cmp.config.sources({
                    { name = "lazydev", group_index = 0 },
                    { name = "nvim_lsp" },
                    { name = "snippy" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            }
        end,
    },
}

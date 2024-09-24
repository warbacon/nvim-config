return {
    -- TS-COMMENTS =============================================================
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {
            lang = {
                rasi = { "// %s", "/* %s */" },
            },
        },
    },

    -- MINI.SURROUND ===========================================================
    {
        "echasnovski/mini.surround",
        keys = {
            { "s", mode = { "n", "v" } },
        },
        opts = {},
    },

    -- AUTOPAIRS ===============================================================
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

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
        "yioneko/nvim-cmp",
        branch = "perf-up",
        event = "InsertEnter",
        dependencies = {
            "nvim-snippy",
            "dcampos/cmp-snippy",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        opts = function()
            local cmp = require("cmp")
            local kinds = {
                Text = " ",
                Method = " ",
                Function = " ",
                Constructor = " ",
                Field = " ",
                Variable = " ",
                Class = " ",
                Interface = " ",
                Module = " ",
                Property = " ",
                Unit = " ",
                Value = " ",
                Enum = " ",
                Keyword = " ",
                Snippet = " ",
                Color = " ",
                File = " ",
                Reference = " ",
                Folder = " ",
                EnumMember = " ",
                Constant = " ",
                Struct = " ",
                Event = " ",
                Operator = " ",
                TypeParameter = " ",
            }

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            return {
                snippet = {
                    expand = function(args)
                        require("snippy").expand_snippet(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                formatting = {
                    format = function(_, item)
                        if kinds[item.kind] then
                            item.kind = kinds[item.kind] .. item.kind
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
                }),
                view = {
                    entries = { follow_cursor = true },
                },
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

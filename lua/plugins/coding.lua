return {
    -- TS-COMMENTS.NVIM ========================================================
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {
            lang = {
                rasi = { "// %s", "/* %s */" },
            },
        },
    },

    -- NVIM-SURROUND ===========================================================
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },

    -- NVIM-TS-AUTOTAG =========================================================
    {
        "windwp/nvim-ts-autotag",
        event = "File",
        opts = {},
    },

    -- MINI.MOVE ===============================================================
    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        opts = {},
    },

    -- MINI.AI =================================================================
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }),
                    c = ai.gen_spec.treesitter({
                        a = "@class.outer",
                        i = "@class.inner",
                    }),
                },
            }
        end,
    },

    -- TREESJ ==================================================================
    {
        "Wansmer/treesj",
        keys = {
            {
                "<leader>j",
                function()
                    require("treesj").join()
                end,
                mode = "n",
            },
            {
                "<leader>s",
                function()
                    require("treesj").split()
                end,
                mode = "n",
            },
        },
        opts = { use_default_keymaps = false },
    },

    -- NVIM-SNIPPY =============================================================
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

    -- NVIM-CMP ================================================================
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
            local snippy = require("snippy")
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

            return {
                snippet = {
                    expand = function(args)
                        snippy.expand_snippet(args.body)
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

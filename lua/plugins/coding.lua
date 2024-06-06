return {
    -- TS-COMMENTS.NVIM ========================================================
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = { lang = { hyprlang = "# %s" } },
    },

    -- NVIM-SURROUND ===========================================================
    {
        "kylechui/nvim-surround",
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

    -- NVIM-CMP ================================================================
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(_, item)
                        local icons = require("util").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind]
                        end
                        return item
                    end,
                },
                snippet = {
                    expand = function(snippet)
                        local session = vim.snippet.active() and vim.snippet._session or nil

                        pcall(vim.snippet.expand, snippet.body)

                        if session then
                            vim.snippet._session = session
                        end
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<S-CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                }),
                view = {
                    entries = {
                        follow_cursor = true,
                    },
                },
                sources = cmp.config.sources({
                    { name = "lazydev", group_index = 0 },
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            }
        end,
    },
}

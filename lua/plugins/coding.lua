return {
    -- TS-COMMENTS.NVIM --------------------------------------------------------
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = { lang = { hyprlang = "# %s" } },
    },

    -- NVIM-SURROUND -----------------------------------------------------------
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },

    -- MINI.AI -----------------------------------------------------------------
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
                },
            }
        end,
    },

    -- TREESJ ------------------------------------------------------------------
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
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            use_default_keymaps = false,
        },
    },

    -- NVIM-CMP ----------------------------------------------------------------
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind.nvim",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local choice = require("lspkind").cmp_format({
                            mode = "symbol",
                            ellipsis_char = "…",
                            maxwidth = 40,
                        })(entry, vim_item)

                        if choice.menu ~= nil and choice.menu:len() > 15 then
                            choice.menu = string.sub(choice.menu, 1, 15) .. "…"
                        end

                        return choice
                    end,
                },
                snippet = {
                    expand = function(arg)
                        vim.snippet.expand(arg.body)
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
                    ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                    ["<C-l>"] = cmp.mapping(function()
                        if vim.snippet.active({ direction = 1 }) then
                            vim.snippet.jump(1)
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if vim.snippet.active({ direction = -1 }) then
                            vim.snippet.jump(-1)
                        end
                    end, { "i", "s" }),
                }),
                view = {
                    entries = {
                        follow_cursor = true,
                    },
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            }
        end,
    },
}

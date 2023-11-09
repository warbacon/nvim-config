return {
    -- CATPPUCCIN
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            custom_highlights = function()
                return {
                    CursorLine = { bg = "None" },
                }
            end,
            integrations = {
                mason = true,
            },
        },
        init = function()
            vim.cmd.colorscheme("catppuccin")
            vim.opt.cursorline = true
        end,
    },

    -- GITSIGNS
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {},
    },

    -- MARKDOWN-PREVIEW
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- -- FTERM
    -- {
    --     "numToStr/fterm.nvim",
    --     keys = {
    --         { '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>',            mode = "n" },
    --         { '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = "t" },
    --         { '<A-g>', mode = "n" }
    --     },
    --     config = function()
    --         local fterm = require("FTerm")
    --
    --         fterm.setup({
    --             cmd = os.getenv("SHELL") or "pwsh -NoLogo" or "powershell -NoLogo"
    --         })
    --
    --         if vim.fn.executable('gitui') == 1 then
    --             local gitui = fterm:new({
    --                 ft = 'fterm_gitui',
    --                 cmd = "gitui"
    --             })
    --
    --             vim.keymap.set({ 'n', 't' }, '<A-g>', function()
    --                 gitui:toggle()
    --             end)
    --         end
    --     end,
    -- },

    -- COMMENTS
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        },
    },

    -- TREESITTER
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        config = function()
            require("nvim-treesitter.install").prefer_git = false
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "diff",
                    "html",
                    "javascript",
                    "svelte",
                    "jsdoc",
                    "json",
                    "jsonc",
                    "lua",
                    "luadoc",
                    "luap",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "xml",
                    "yaml",
                },
            })
        end,
    },

    -- KITTY CONFIG HIGHLIGHTING
    {
        "fladson/vim-kitty",
        ft = "kitty",
        enabled = os.getenv("TERM") == "xterm-kitty",
    },

    -- CLIPS
    {
        -- dir = "~/Git/vim-clips",
        "Warbacon/vim-clips",
        enabled = false,
        ft = "clips",
    },

    -- MASON
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "bash-language-server",
                "ruff-lsp",
                "svelte-language-server",
                "json-lsp",
                "html-lsp",
                "css-lsp",
                "pyright",
                "clangd",
                "shellcheck",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },

    -- TELESCOPE
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", mode = "n" },
            { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>",  mode = "n" },
            { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>",    mode = "n" },
            { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>",  mode = "n" },
        },
    },

    -- LSPCONFIG
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            "b0o/schemastore.nvim"
        },
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            -- Setup mason-lspconfig.
            require("mason-lspconfig").setup()

            -- Setup Neodev.
            require("neodev").setup()

            -- Setup language servers.
            local lspconfig = require("lspconfig")

            if not jit.os:find("Windows") then
                lspconfig.bashls.setup({})
                lspconfig.clangd.setup({})
            end

            lspconfig.pyright.setup({})
            lspconfig.svelte.setup({})
            lspconfig.html.setup({})
            lspconfig.cssls.setup({})
            lspconfig.ruff_lsp.setup({
                init_options = {
                    settings = {
                        -- Any extra CLI arguments for `ruff` go here.
                        args = {
                            "--ignore",
                            "405",
                        },
                    },
                },
            })
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = "Disable",
                        },
                        diagnostics = {
                            disable = {
                                "missing-fields",
                            },
                        },
                    },
                },
            })

            --Enable (broadcasting) snippet capability for completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            require('lspconfig').jsonls.setup {
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            }

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<space>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<space>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })
        end,
    },

    -- COMPLETIONS
    {
        "L3MON4D3/LuaSnip",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
}

return {
    -- CATPPUCCIN
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
            vim.opt.cursorline = true
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "None" })
        end,
    },

    -- INDENT BLANKLINE
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            scope = { enabled = false },
        },
    },

    -- INDENT-O-MATIC
    {
        "Darazaki/indent-o-matic",
        event = { "BufReadPre", "BufNewFile" },
        opts = {}
    },

    -- GITSIGNS
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
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

    -- FTERM
    {
        "numToStr/fterm.nvim",
        keys = {
            { '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>',            mode = "n" },
            { '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = "t" },
            { '<A-g>', mode = "n" }
        },
        config = function()
            local fterm = require("FTerm")

            fterm.setup({
                cmd = os.getenv("SHELL") or "pwsh -NoLogo" or "powershell -NoLogo"
            })

            if vim.fn.executable('gitui') == 1 then
                local gitui = fterm:new({
                    ft = 'fterm_gitui',
                    cmd = "gitui"
                })

                vim.keymap.set({ 'n', 't' }, '<A-g>', function()
                    gitui:toggle()
                end)
            end
        end,
    },

    -- COMMENTS
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },

    -- TREESITTER
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "diff",
                    "gitignore",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "toml",
                    "vim",
                    "vimdoc",
                    "xml",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                auto_install = false,
            })
        end,
    },

    -- KITTY CONFIG HIGHLIGHTING
    {
        "fladson/vim-kitty",
        ft = "kitty",
        enabled = not (jit.os:find("Windows") or vim.fn.has("wsl") == 1)
    },

    -- CLIPS
    {
        -- dir = "~/Git/vim-clips",
        "Warbacon/vim-clips",
        ft = "clips"
    },

    -- MASON
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "lua-language-server",
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

    -- LSPCONFIG
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
        },
        ft = { "python", "sh", "lua", "c", "cpp" },
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
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            disable = {
                                "missing-fields",
                            },
                        },
                    },
                },
            })

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
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
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
                    {
                        "<tab>",
                        function()
                            require("luasnip").jump(1)
                        end,
                        mode = "s",
                    },
                    {
                        "<s-tab>",
                        function()
                            require("luasnip").jump(-1)
                        end,
                        mode = { "i", "s" },
                    },
                },
            },
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

vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/Darazaki/indent-o-matic" },
    { src = "https://github.com/dstein64/vim-startuptime" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/kevinhwang91/nvim-bqf" },
    { src = "https://github.com/stevearc/quicker.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
})

vim.keymap.set("n", "<Leader>pu", vim.pack.update)
vim.keymap.set("n", "<Leader>pr", function()
    vim.pack.update(nil, { target = "lockfile" })
end)

-- tokyonight.nvim
require("tokyonight").setup({
    plugins = {
        all = false,
        blink = true,
        mini_diff = true,
        mini_icons = true,
        treesitter = true,
    },
    on_highlights = function(hl, c)
        hl.PmenuBorder = { link = "FloatBorder" }
        hl.MatchParen = {
            bg = c.fg_gutter,
            bold = true,
        }
    end,
})
vim.cmd.colorscheme("tokyonight-night")

-- mini.nvim
require("mini.icons").setup()
require("mini.move").setup()
require("mini.diff").setup({
    view = {
        style = "sign",
    },
})
require("mini.splitjoin").setup({
    mappings = {
        toggle = "gs",
    },
})
require("mini.pick").setup({
    options = {
        use_cache = true,
    },
    mappings = {
        choose_marked = "<C-Q>",
    },
})
vim.keymap.set("n", "<Leader>f", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<Leader>sg", "<Cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<Leader>sh", "<Cmd>Pick help<CR>")
vim.keymap.set("n", "<Leader>,", "<Cmd>Pick buffers<CR>")
vim.keymap.set("n", "<Leader>sd", function()
    require("mini.extra").pickers.diagnostic({ scope = "all" })
end)
vim.keymap.set("n", "z=", require("mini.extra").pickers.spellsuggest)

-- lsp
require("lazydev").setup()
vim.lsp.enable({ "lua_ls" })

-- conform.nvim
require("conform").setup({
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        lua = { "stylua" },
    },
})

-- treesitter
require("nvim-treesitter").install({
    "diff",
    "gitcommit",
    "html",
    "ini",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "nix",
    "powershell",
    "toml",
    "vimdoc",
    "vimscript",
    "xml",
    "yaml",
})

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        end
    end,
})

require("nvim-ts-autotag").setup()

vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        local is_active = vim.treesitter.highlighter.active[ev.buf] ~= nil

        if not is_active then
            is_active = pcall(vim.treesitter.start)
        end

        if is_active then
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"

            local lang = vim.treesitter.language.get_lang(ev.match)
            if lang and vim.treesitter.query.get(lang, "indents") then
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end
    end,
})

-- oil.nvim
require("oil").setup({
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    keymaps = {
        ["`"] = false,
        ["~"] = false,
        [","] = { "actions.cd", mode = "n" },
    },
    view_options = {
        show_hidden = true,
    },
})
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true })

-- quicker.nvim
require("quicker").setup()

-- blink.cmp
vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    callback = function()
        require("blink.cmp").setup({
            cmdline = {
                completion = {
                    list = {
                        selection = {
                            preselect = false,
                        },
                    },
                    menu = {
                        auto_show = true,
                    },
                },
            },
            appearance = {
                kind_icons = Util.icons.kinds,
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
                menu = {
                    draw = {
                        gap = 2,
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 2 },
                        },
                    },
                },
            },
            sources = {
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                    vim = { inherit_defaults = true, "cmdline" },
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    path = {
                        opts = {
                            show_hidden_files_by_default = true,
                        },
                    },
                },
            },
        })
    end,
})

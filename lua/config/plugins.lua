vim.pack.add({
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
    { src = "https://github.com/fei6409/log-highlight.nvim" },
    { src = "https://github.com/fladson/vim-kitty" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/kevinhwang91/nvim-bqf" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/tpope/vim-sleuth" },
}, { confirm = false })

-- TOKYONIGHT ---------------------------------------------------------------{{{

require("tokyonight").setup({
    on_highlights = function(hl, c)
        hl.MatchParen = {
            bg = c.fg_gutter,
            bold = true,
        }
    end,
    plugins = {
        all = false,
        ["render-markdown"] = true,
        blink = true,
        fzf = true,
        gitsigns = true,
        mini_icons = true,
    },
})

vim.cmd.colorscheme("tokyonight-night")

-- }}}

-- TREE-SITTER --------------------------------------------------------------{{{

local ts_parsers = {
    "astro",
    "bash",
    "c",
    "cpp",
    "css",
    "dockerfile",
    "fish",
    "gitcommit",
    "html",
    "hyprlang",
    "ini",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "markdown_inline",
    "nix",
    "printf",
    "python",
    "rasi",
    "regex",
    "svelte",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
}

require("nvim-treesitter").install(ts_parsers)

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.kind == "update" and ev.data.spec.name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if pcall(vim.treesitter.start) then
            if vim.treesitter.query.get(vim.treesitter.get_parser():lang(), "indents") then
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end
    end,
})

-- }}}

-- LSP ----------------------------------------------------------------------{{{

vim.lsp.enable({
    "astro",
    "basedpyright",
    "bashls",
    "clangd",
    "cssls",
    "emmet_language_server",
    "html",
    "jdtls",
    "jsonls",
    "lua_ls",
    "nixd",
    "qmlls",
    "svelte",
    "tailwindcss",
    "vtsls",
    "yamlls",
})

vim.lsp.on_type_formatting.enable()

-- }}}

-- CONFORM ------------------------------------------------------------------{{{

require("conform").setup({
    formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        fish = { "fish_indent" },
        lua = { "stylua" },
        sh = { "shfmt" },
        ["*"] = { "injected" },
        ["_"] = { "trim_whitespace", "trim_newlines", lsp_format = "prefer" },
    },
    formatters = {
        shfmt = {
            append_args = { "-i=4", "-ci", "-bn" },
        },
        ["clang-format"] = {
            append_args = {
                "-style={IndentWidth: 4, BreakBeforeBraces: Linux, AccessModifierOffset: -4, ColumnLimit: 100}",
            },
        },
    },
})

vim.keymap.set("n", "<Leader>cf", require("conform").format)

-- }}}

-- FZF-LUA ------------------------------------------------------------------{{{

require("fzf-lua").setup({
    fzf_colors = true,
    keymap = {
        builtin = {
            ["<F1>"] = "toggle-help",
            ["<M-m>"] = "toggle-fullscreen",
            ["<M-p>"] = "toggle-preview",
        },
    },
})
vim.ui.select = require("fzf-lua.providers.ui_select").ui_select
vim.keymap.set("n", "<Leader>f", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>sd", "<Cmd>FzfLua diagnostics_workspace<CR>")
vim.keymap.set("n", "<Leader>sg", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>sh", "<Cmd>FzfLua helptags<CR>")
vim.keymap.set("n", "z=", "<Cmd>FzfLua spell_suggest<CR>")

-- }}}

-- MINI ---------------------------------------------------------------------{{{

require("mini.icons").setup()
require("mini.move").setup()
require("mini.misc").setup_termbg_sync()

require("mini.splitjoin").setup({
    mappings = {
        toggle = "gs",
    },
})

-- }}}

-- BLINK.CMP ----------------------------------------------------------------{{{

require("blink.cmp").setup({
    cmdline = { enabled = false },
    appearance = {
        kind_icons = Util.icons.kinds,
        nerd_font_variant = "normal",
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
    },
    sources = {
        providers = {
            path = {
                opts = {
                    show_hidden_files_by_default = true,
                },
            },
        },
    },
})

-- }}}

-- OIL ----------------------------------------------------------------------{{{

require("oil").setup({
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    lsp_file_methods = {
        autosave_changes = "unmodified",
    },
    keymaps = {
        ["`"] = false,
        ["~"] = false,
        [","] = { "actions.cd", mode = "n" },
    },
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set("n", "-", "<Cmd>Oil<CR>")

-- }}}

-- GITSIGNS -----------------------------------------------------------------{{{

require("gitsigns").setup({
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end)

        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end)

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)

        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("n", "<leader>hS", gitsigns.stage_buffer)
        map("n", "<leader>hR", gitsigns.reset_buffer)
        map("n", "<leader>hp", gitsigns.preview_hunk)
        map("n", "<leader>hi", gitsigns.preview_hunk_inline)

        map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end)

        map("n", "<leader>hd", gitsigns.diffthis)

        map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
        end)

        map("n", "<leader>hQ", function()
            gitsigns.setqflist("all")
        end)
        map("n", "<leader>hq", gitsigns.setqflist)

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
        map("n", "<leader>tw", gitsigns.toggle_word_diff)

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
    end,
})

-- }}}

-- RENDER-MARKDOWN ----------------------------------------------------------{{{

require("render-markdown").setup({
    completions = {
        lsp = { enabled = true },
    },
    heading = {
        sign = false,
    },
    code = {
        sign = false,
    },
    overrides = {
        buftype = {
            nofile = {
                code = {
                    language = false,
                    border = "none",
                },
            },
        },
    },
})

-- }}}

-- vim: foldmethod=marker

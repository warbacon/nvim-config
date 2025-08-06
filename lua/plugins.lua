vim.pack.add({
    "https://github.com/echasnovski/mini.diff",
    "https://github.com/echasnovski/mini.icons",
    "https://github.com/echasnovski/mini.move",
    "https://github.com/echasnovski/mini.splitjoin",
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/tpope/vim-sleuth",
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- TOKYONIGHT ------------------------------------------------------------------
require("tokyonight").setup({
    on_highlights = function(hl, c)
        hl.MatchParen = {
            bg = c.fg_gutter,
            bold = true,
        }
    end,
    plugins = {
        all = false,
        fzf = true,
        mini_icons = true,
        blink = true,
    },
})
vim.cmd.colorscheme("tokyonight-night")

-- MINI ------------------------------------------------------------------------
require("mini.icons").setup()
require("mini.move").setup()
require("mini.splitjoin").setup({
    mappings = {
        toggle = "gs",
    },
})
require("mini.diff").setup({
    view = {
        style = "sign",
    },
})
vim.keymap.set("n", "ghp", require("mini.diff").toggle_overlay)

-- FZF-LUA ---------------------------------------------------------------------
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
require("fzf-lua").register_ui_select()

vim.keymap.set("n", "<Leader>f", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>sd", "<Cmd>FzfLua diagnostics_workspace<CR>")
vim.keymap.set("n", "<Leader>sg", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>sg", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>sh", "<Cmd>FzfLua helptags<CR>")
vim.keymap.set("n", "<Leader>sh", "<Cmd>FzfLua helptags<CR>")
vim.keymap.set("n", "z=", "<Cmd>FzfLua spell_suggest<CR>")

-- BLINK.CMP -------------------------------------------------------------------
require("blink.cmp").setup({
    cmdline = { enabled = false },
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

-- OIL -------------------------------------------------------------------------
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

-- CONFORM ---------------------------------------------------------------------
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

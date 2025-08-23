vim.pack.add({
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/fei6409/log-highlight.nvim" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/kevinhwang91/nvim-bqf" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
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
    "jsonls",
    "lua_ls",
    "nixd",
    "qmlls",
    "svelte",
    "tailwindcss",
    "vtsls",
    "yamlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client:supports_method("textDocument/documentColor") then
            vim.lsp.document_color.enable(true, args.buf)
        end
    end,
})
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
Util.later(function()
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
end)
-- }}}

-- MINI ---------------------------------------------------------------------{{{
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
-- }}}

-- BLINK.CMP ----------------------------------------------------------------{{{
Util.later(function()
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
end)
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

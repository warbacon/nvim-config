Util.bootstrap_lazy()

---@type LazySpec
local plugins = {
    { "MeanderingProgrammer/render-markdown.nvim" },
    { "Saghen/blink.cmp", version = "1.*" },
    { "folke/lazydev.nvim" },
    { "folke/tokyonight.nvim" },
    { "ibhagwan/fzf-lua" },
    { "kevinhwang91/nvim-bqf" },
    { "lewis6991/gitsigns.nvim" },
    { "mfussenegger/nvim-jdtls" },
    { "neovim/nvim-lspconfig" },
    { "nvim-mini/mini.nvim" },
    { "stevearc/conform.nvim" },
    { "stevearc/oil.nvim" },
    { "tpope/vim-sleuth" },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = function()
            require("nvim-treesitter").update()
        end,
    },
}

require("lazy").setup(plugins, {
    install = { colorscheme = { "tokyonight-night" } },
    ui = { border = vim.o.winborder },
})

local later = require("mini.deps").later
local now = require("mini.deps").now
local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- TOKYONIGHT ---------------------------------------------------------------{{{

require("tokyonight").setup({
    on_highlights = function(hl, c)
        hl.MatchParen = {
            bg = c.fg_gutter,
            bold = true,
        }
    end,
})

vim.cmd.colorscheme("tokyonight-night")

-- }}}

-- TREE-SITTER --------------------------------------------------------------{{{

now_if_args(function()
    local ts_parsers = {
        "astro",
        "bash",
        "c",
        "cpp",
        "css",
        "fish",
        "gitcommit",
        "go",
        "html",
        "hyprlang",
        "ini",
        "java",
        "javascript",
        "json",
        "jsonc",
        "kitty",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "printf",
        "python",
        "regex",
        "svelte",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    }

    if vim.fn.has("win32") == 0 then
        require("nvim-treesitter").install(ts_parsers):wait(100000)
    end

    vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
            local lang = vim.treesitter.language.get_lang(ev.match)

            if Util.treesitter.get_installed()[lang] then
                vim.treesitter.start()
                if lang and vim.treesitter.query.get(lang, "indents") then
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end
        end,
    })
end)

-- }}}

-- LSP ----------------------------------------------------------------------{{{

now_if_args(function()
    vim.lsp.enable({
        "astro",
        "basedpyright",
        "bashls",
        "clangd",
        "cssls",
        "emmet_language_server",
        "gopls",
        "html",
        "intelephense",
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

    if vim.fn.has("nvim-0.12") == 1 then
        vim.lsp.on_type_formatting.enable()
    end

    require("lazydev").setup({
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    })
end)

-- }}}

-- CONFORM ------------------------------------------------------------------{{{

later(function()
    require("conform").setup({
        formatters_by_ft = {
            c = { "clang-format" },
            cpp = { "clang-format" },

            fish = { "fish_indent" },

            lua = { "stylua" },

            sh = { "shfmt" },

            toml = { "taplo" },

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
end)

-- }}}

-- FZF-LUA ------------------------------------------------------------------{{{

later(function()
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
end)

-- }}}

-- MINI ---------------------------------------------------------------------{{{

require("mini.icons").setup()

later(function()
    require("mini.misc").setup_termbg_sync()
end)

later(function()
    require("mini.move").setup()
end)

later(function()
    require("mini.splitjoin").setup({
        mappings = {
            toggle = "gs",
        },
    })
end)

-- }}}

-- BLINK.CMP ----------------------------------------------------------------{{{

later(function()
    require("blink.cmp").setup({
        cmdline = { enabled = false },
        appearance = {
            kind_icons = Util.icons.kinds,
            nerd_font_variant = "normal",
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        sources = {
            per_filetype = {
                lua = { inherit_defaults = true, "lazydev" },
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
end)

-- }}}

-- OIL ----------------------------------------------------------------------{{{

now_if_args(function()
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
end)

-- }}}

-- GITSIGNS -----------------------------------------------------------------{{{

later(function()
    require("gitsigns").setup({
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]h", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end)

            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[h", bang = true })
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
end)

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

-- UNDOTREE -----------------------------------------------------------------{{{

if vim.fn.has("nvim-0.12") == 1 then
    later(function()
        vim.cmd.packadd("nvim.undotree")
        vim.keymap.set("n", "<Leader>u", "<Cmd>Undotree<CR>", { silent = true, noremap = true })
    end)
end

-- }}}

-- vim: foldmethod=marker

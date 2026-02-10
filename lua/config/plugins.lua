vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/Darazaki/indent-o-matic" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/kevinhwang91/nvim-bqf" },
    { src = "https://github.com/stevearc/quicker.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
})

vim.keymap.set("n", "<Leader>pu", vim.pack.update, { desc = "Update plugins" })
vim.keymap.set("n", "<Leader>pr", function()
    vim.pack.update(nil, { target = "lockfile" })
end, { desc = "Restore plugins from lockfile" })
vim.keymap.set("n", "<Leader>px", function()
    vim.pack.del(vim.iter(vim.pack.get())
        :filter(function(x)
            return not x.active
        end)
        :map(function(x)
            return x.spec.name
        end)
        :totable())
end, { desc = "Delete non-active plugins" })

-----------------------------------------------------------------------------------------------------------------------
-- MINI.NVIM
-----------------------------------------------------------------------------------------------------------------------

require("mini.icons").setup()
require("mini.clue").setup({
    triggers = {
        { mode = { "n", "x" }, keys = "<Leader>" },
        { mode = { "n", "x" }, keys = "[" },
        { mode = { "n", "x" }, keys = "]" },
        { mode = "i", keys = "<C-x>" },
        { mode = { "n", "x" }, keys = "g" },
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = { "n", "x" }, keys = "z" },
    },
    clues = {
        { mode = { "n" }, keys = "<Leader>p", desc = "vim.pack" },
        { mode = { "n" }, keys = "<Leader>s", desc = "mini.pick" },
        { mode = { "n" }, keys = "<Leader>r", desc = "Restart Neovim" },
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.square_brackets(),
        require("mini.clue").gen_clues.windows({ submode_resize = true }),
        require("mini.clue").gen_clues.z(),
    },
})
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
vim.keymap.set("n", "<Leader>f", "<Cmd>Pick files<CR>", { desc = "Pick files" })
vim.keymap.set("n", "<Leader>sg", "<Cmd>Pick grep_live<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<Leader>sh", "<Cmd>Pick help<CR>", { desc = "Search help tags" })
vim.keymap.set("n", "<Leader>,", "<Cmd>Pick buffers<CR>", { desc = "Show buffers" })
vim.keymap.set("n", "<Leader>sd", function()
    require("mini.extra").pickers.diagnostic({ scope = "all" })
end, { desc = "Show workspace diagnostics" })
vim.keymap.set("n", "z=", require("mini.extra").pickers.spellsuggest, { desc = "Show spell suggestions" })

-----------------------------------------------------------------------------------------------------------------------
-- LSP
-----------------------------------------------------------------------------------------------------------------------

vim.lsp.enable({
    "bashls",
    "clangd",
    "cssls",
    "emmet_language_server",
    "jsonls",
    "lua_ls",
    "nixd",
    "qmlls",
    "svelte",
    "tailwindcss",
    "tsgo",
    "yamlls",
})

-----------------------------------------------------------------------------------------------------------------------
-- CONFORM.NVIM
-----------------------------------------------------------------------------------------------------------------------

local PRETTIER = { "prettier", lsp_format = "fallback", timeout = 1000 }
require("conform").setup({
    format_on_save = true,
    formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        fish = { "fish_indent" },
        lua = { "stylua" },
        toml = { "taplo" },
        css = PRETTIER,
        html = PRETTIER,
        javascript = PRETTIER,
        javascriptreact = PRETTIER,
        json = PRETTIER,
        jsonc = PRETTIER,
        typescript = PRETTIER,
        typescriptreact = PRETTIER,
        ["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks", lsp_format = "last" },
    },
    formatters = {
        ["clang-format"] = {
            append_args = {
                "-style={IndentWidth: 4, BreakBeforeBraces: Linux, ColumnLimit: 80}",
            },
        },
    },
})

----------------------------------------------------------------------------------------------------
-- TREESITTER
----------------------------------------------------------------------------------------------------

local ts_parsers = {
    "c",
    "cpp",
    "css",
    "diff",
    "gitcommit",
    "html",
    "ini",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "svelte",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
}

if vim.fn.has("linux") == 1 then
    vim.list_extend(ts_parsers, {
        "bash",
        "fish",
        "nix",
    })
end

if vim.fn.has("windows") == 1 then
    vim.list_extend(ts_parsers, {
        "powershell",
    })
end

require("nvim-treesitter").install(ts_parsers)

vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Auto-update Treesitter parsers when the plugin is updated",
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable Treesitter when available",
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

require("nvim-ts-autotag").setup()

-----------------------------------------------------------------------------------------------------------------------
-- OIL.NVIM
-----------------------------------------------------------------------------------------------------------------------

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
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, desc = "Open Oil file manager" })

-----------------------------------------------------------------------------------------------------------------------
-- BLINK.CMP
-----------------------------------------------------------------------------------------------------------------------

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
                    vim = { inherit_defaults = true, "cmdline" },
                },
                providers = {
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

-----------------------------------------------------------------------------------------------------------------------
-- QUICKER.NVIM
-----------------------------------------------------------------------------------------------------------------------

require("quicker").setup()

-----------------------------------------------------------------------------------------------------------------------
-- UNDOTREE
-----------------------------------------------------------------------------------------------------------------------
local undotree = function()
    if not vim.g.loaded_undotree_plugin then
        vim.cmd("packadd nvim.undotree")
    end
    require("undotree").open()
end

vim.keymap.set("n", "<Leader>u", undotree, { desc = "Undotree" })
vim.api.nvim_create_user_command("Undotree", undotree, {})

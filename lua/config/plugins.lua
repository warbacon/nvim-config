-- vim.opt.rtp:prepend(vim.fs.joinpath(vim.env.HOME, "Proyectos/pino.nvim"))
vim.pack.add({
    { src = "https://github.com/warbacon/pino.nvim" },
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
    { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/mistweaverco/kulala.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/b0o/SchemaStore.nvim" },
})

vim.keymap.set("n", "<Leader>pu", vim.pack.update, { desc = "Update plugins" })
vim.keymap.set("n", "<Leader>pr", function()
    vim.pack.update(nil, { target = "lockfile" })
end, { desc = "Restore plugins from lockfile" })
vim.keymap.set("n", "<Leader>pc", function()
    vim.pack.del(vim.iter(vim.pack.get())
        :filter(function(x)
            return not x.active
        end)
        :map(function(x)
            return x.spec.name
        end)
        :totable())
end, { desc = "Delete non-active plugins" })

local now = function(f)
    require("mini.misc").safely("now", f)
end
local later = function(f)
    require("mini.misc").safely("later", f)
end
local now_if_args = vim.fn.argc(-1) > 0 and now or later
local on_event = function(ev, f)
    require("mini.misc").safely("event:" .. ev, f)
end
local on_filetype = function(ft, f)
    require("mini.misc").safely("filetype:" .. ft, f)
end

-----------------------------------------------------------------------------------------------------------------------
-- PINO.NVIM
-----------------------------------------------------------------------------------------------------------------------

require("pino").setup({
    plugins = {
        mini = true,
        fzf_lua = true,
        lazy = false,
    },
})
vim.cmd.colorscheme("pino")

----------------------------------------------------------------------------------------------------
-- TREESITTER
----------------------------------------------------------------------------------------------------

now_if_args(function()
    local ts_parsers = {
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "fish",
        "gitcommit",
        "html",
        "ini",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "powershell",
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
end)

-----------------------------------------------------------------------------------------------------------------------
-- MINI.NVIM
-----------------------------------------------------------------------------------------------------------------------

now(function()
    require("mini.icons").setup()
end)
later(function()
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
            { mode = { "n" }, keys = "<Leader>s", desc = "FzfLua" },
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
end)
later(function()
    require("mini.move").setup()
end)
later(function()
    require("mini.diff").setup({
        view = {
            style = "sign",
        },
    })
end)
later(function()
    require("mini.splitjoin").setup()
end)

-----------------------------------------------------------------------------------------------------------------------
-- LSP
-----------------------------------------------------------------------------------------------------------------------

now(function()
    vim.lsp.enable({
        "bashls",
        "clangd",
        "cssls",
        "emmet_language_server",
        "jsonls",
        "lua_ls",
        "qmlls",
        "rumdl",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "tsgo",
        "yamlls",
    })

    if vim.fn.has("win32") == 1 then
        vim.lsp.enable("powershell_es")
    end
end)

-----------------------------------------------------------------------------------------------------------------------
-- CONFORM.NVIM
-----------------------------------------------------------------------------------------------------------------------

now(function()
    require("conform").setup({
        format_on_save = true,
        formatters_by_ft = {
            c = { "clang-format" },
            cpp = { "clang-format" },
            fish = { "fish_indent" },
            lua = { "stylua" },
            toml = { "taplo" },
            css = { "prettierd" },
            html = { "prettierd" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            jsonc = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
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
end)

-----------------------------------------------------------------------------------------------------------------------
-- MASON
-----------------------------------------------------------------------------------------------------------------------

now_if_args(function()
    require("mason").setup()
    require("mason-lspconfig").setup()

    vim.keymap.set("n", "<Leader>m", "<cmd>Mason<CR>")

    local mr = require("mason-registry")
    mr.refresh(function()
        local servers = vim.lsp._enabled_configs
        local mappings = require("mason-lspconfig").get_mappings().lspconfig_to_package
        local formatters_by_ft = require("conform").formatters_by_ft

        local to_install = {
            shellcheck = true,
            shfmt = true,
            ["rust-analyzer"] = false,
        }

        for _, server in ipairs(vim.tbl_keys(servers)) do
            local package_name = mappings[server]
            if package_name and to_install[package_name] ~= false then
                to_install[package_name] = true
            end
        end

        for _, formatters in pairs(formatters_by_ft) do
            for _, formatter in ipairs(formatters) do
                if type(formatter) == "string" and mr.has_package(formatter) then
                    to_install[formatter] = true
                end
            end
        end

        for package_name in pairs(to_install) do
            if not mr.is_installed(package_name) then
                mr.get_package(package_name):install()
            end
        end
    end)
end)

-----------------------------------------------------------------------------------------------------------------------
-- OIL.NVIM
-----------------------------------------------------------------------------------------------------------------------

now(function()
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
        watch_for_changes = true,
    })
    vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, desc = "Open Oil file manager" })
end)

-----------------------------------------------------------------------------------------------------------------------
-- FZF-LUA
-----------------------------------------------------------------------------------------------------------------------

later(function()
    require("fzf-lua").setup({
        fzf_colors = true,
        ui_select = true,
        files = { formatter = "path.filename_first" },
    })

    vim.keymap.set("n", "<Leader><Leader>", "<Cmd>FzfLua files<CR>", { desc = "FzfLua files" })
    vim.keymap.set("n", "<Leader>sg", "<Cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
    vim.keymap.set("n", "<Leader>sh", "<Cmd>FzfLua helptags<CR>", { desc = "Search help tags" })
    vim.keymap.set("n", "<Leader>,", "<Cmd>FzfLua buffers<CR>", { desc = "Show open buffers" })
    vim.keymap.set("n", "<Leader>sd", "<Cmd>FzfLua diagnostics_workspace<CR>", { desc = "Show workspace diagnostics" })
    vim.keymap.set("n", "z=", "<Cmd>FzfLua spell_suggest<CR>", { desc = "Show spell suggestions" })
end)

-----------------------------------------------------------------------------------------------------------------------
-- BLINK.CMP
-----------------------------------------------------------------------------------------------------------------------

on_event("InsertEnter,CmdlineEnter", function()
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
end)

-----------------------------------------------------------------------------------------------------------------------
-- UNDOTREE
-----------------------------------------------------------------------------------------------------------------------

later(function()
    local undotree = function()
        if not vim.g.loaded_undotree_plugin then
            vim.cmd("packadd nvim.undotree")
        end
        require("undotree").open()
    end

    vim.keymap.set("n", "<Leader>u", undotree, { desc = "Undotree" })
    vim.api.nvim_create_user_command("Undotree", undotree, {})
end)

-----------------------------------------------------------------------------------------------------------------------
-- KULALA.NVIM
-----------------------------------------------------------------------------------------------------------------------

on_filetype("http", function()
    require("kulala").setup({
        global_keymaps = true,
    })
end)

-----------------------------------------------------------------------------------------------------------------------
-- QUICKER.NVIM
-----------------------------------------------------------------------------------------------------------------------

on_filetype("qf", function()
    require("quicker").setup()
end)

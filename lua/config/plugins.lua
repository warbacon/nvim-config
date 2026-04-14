require("packy").setup({
    -- COLORSCHEMES ---------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/warbacon/pino.nvim",
        path = (function()
            if vim.fn.has("linux") == 1 then
                return vim.fs.joinpath(vim.env.HOME, "Proyectos", "pino.nvim")
            elseif vim.fn.has("win32") == 1 then
                return vim.fs.joinpath(vim.env.USERPROFILE, "Documents", "Proyectos", "pino.nvim")
            end
        end)(),
        config = function()
            require("pino").setup({
                plugins = {
                    mason = not Util.is_nixos,
                    mini = true,
                    fzf_lua = true,
                    lazy = false,
                },
            })
            vim.cmd.colorscheme("pino")
        end,
    },
    { src = "https://github.com/folke/tokyonight.nvim" },

    -- MINI.ICONS -----------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-mini/mini.icons",
        config = function()
            require("mini.icons").setup()
        end,
    },

    -- MINI.CLUE ------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-mini/mini.clue",
        event = "VeryLazy",
        config = function()
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
        end,
    },

    -- MINI.MOVE ------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-mini/mini.move",
        event = "VeryLazy",
        config = function()
            require("mini.move").setup()
        end,
    },

    -- MINI.SPLITJOIN -------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-mini/mini.splitjoin",
        event = "VeryLazy",
        config = function()
            require("mini.splitjoin").setup()
        end,
    },

    -- GUESS-INDENT.NVIM ----------------------------------------------------------------------------------------------
    {
        src = "https://github.com/NMAC427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup()
        end,
    },

    -- LSP ------------------------------------------------------------------------------------------------------------
    { src = "https://github.com/b0o/SchemaStore.nvim" },
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable({
                "bashls",
                "clangd",
                "cssls",
                "emmet_language_server",
                "emmylua_ls",
                "eslint",
                "jsonls",
                "nixd",
                "qmlls",
                "rust_analyzer",
                "svelte",
                "tailwindcss",
                "tsgo",
                "yamlls",
            })

            if vim.fn.has("win32") == 1 then
                vim.lsp.enable("powershell_es")
            end
        end,
    },

    -- TREESITTER -----------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter").update()
        end,
        config = function()
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
        end,
    },
    {
        src = "https://github.com/windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    -- OIL.NVIM -------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/stevearc/oil.nvim",
        config = function()
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
        end,
    },

    -- CONFORM.NVIM ---------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/stevearc/conform.nvim",
        config = function()
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
                    markdown = { "prettierd" },
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
        end,
    },

    -- QUICKFIX -------------------------------------------------------------------------------------------------------
    { src = "https://github.com/kevinhwang91/nvim-bqf" },
    {
        src = "https://github.com/stevearc/quicker.nvim",
        ft = "qf",
        config = function()
            require("quicker").setup()
        end,
    },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("*"),
        preload = true,
        event = { "CmdlineEnter", "InsertEnter" },
        config = function()
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
                    keymap = {
                        preset = "cmdline",
                        ["<Left>"] = false,
                        ["<Right>"] = false,
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
        end,
    },

    -- FZF-LUA --------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/ibhagwan/fzf-lua",
        event = "VeryLazy",
        config = function()
            require("fzf-lua").setup({
                fzf_colors = true,
                ui_select = true,
                files = { formatter = "path.filename_first" },
            })

            vim.keymap.set("n", "<Leader><Leader>", "<Cmd>FzfLua files<CR>", { desc = "FzfLua files" })
            vim.keymap.set("n", "<Leader>sg", "<Cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
            vim.keymap.set("n", "<Leader>sh", "<Cmd>FzfLua helptags<CR>", { desc = "Search help tags" })
            vim.keymap.set("n", "<Leader>,", "<Cmd>FzfLua buffers<CR>", { desc = "Show open buffers" })
            vim.keymap.set(
                "n",
                "<Leader>sd",
                "<Cmd>FzfLua diagnostics_workspace<CR>",
                { desc = "Show workspace diagnostics" }
            )
            vim.keymap.set("n", "z=", "<Cmd>FzfLua spell_suggest<CR>", { desc = "Show spell suggestions" })
        end,
    },

    -- RENDER-MARKDOWN.NVIM -------------------------------------------------------------------------------------------
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

    -- KULALA.NVIM ----------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/mistweaverco/kulala.nvim",
        ft = "http",
        config = function()
            require("kulala").setup({
                global_keymaps = true,
            })
        end,
    },

    -- MASON.NVIM -----------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/mason-org/mason-lspconfig.nvim",
        enabled = not Util.is_nixos,
    },
    {
        src = "https://github.com/mason-org/mason.nvim",
        enabled = not Util.is_nixos,
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_enable = false,
            })

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
        end,
    },

    -- GITSIGNS.NVIM --------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                sign_priority = 199,
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
        end,
    },

    -- NVIM-SCROLLBAR -------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            require("scrollbar").setup({
                handlers = {
                    cursor = false,
                },
            })
        end,
    },

    -- VIM-STARTUPTIME ------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/dstein64/vim-startuptime",
        event = "VeryLazy",
    },
})

-----------------------------------------------------------------------------------------------------------------------
-- UNDOTREE
-----------------------------------------------------------------------------------------------------------------------

local undotree = function()
    if not vim.g.loaded_undotree_plugin then
        vim.cmd.packadd("nvim.undotree")
    end
    require("undotree").open()
end

vim.keymap.set("n", "<Leader>u", undotree, { desc = "Undotree" })
vim.api.nvim_create_user_command("Undotree", undotree, {})

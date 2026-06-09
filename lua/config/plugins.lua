require("packy").setup({
    -------------------------------------------------------------------------------------------------------------------
    -- PINO.NVIM
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/warbacon/pino.nvim",
        dir = (function()
            if vim.fn.has("linux") == 1 then
                return vim.fs.joinpath(os.getenv("HOME") or "", "Proyectos", "pino.nvim")
            end

            if vim.fn.has("win32") == 1 then
                return "F:/pino.nvim"
            end

            return nil
        end)(),
        config = function()
            require("pino").setup({
                plugins = {
                    lazy = false,
                    mason = not Util.is_nixos,
                    mini = true,
                    snacks = true,
                },
            })
            vim.cmd.colorscheme("pino")
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- SNACKS.NVIM
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/folke/snacks.nvim",
        config = function()
            require("snacks").setup({
                image = {
                    enabled = true,
                    doc = { inline = false, max_height = 20 },
                },
                input = {
                    enabled = true,
                    icon_pos = false,
                    win = {
                        relative = "cursor",
                        col = -2,
                        row = -3,
                        title_pos = "left",
                        width = 20,
                        keys = {
                            i_ctrl_a = { "<C-a>", "<Home>", mode = "i", expr = true },
                            i_ctrl_e = { "<C-e>", "<End>", mode = "i", expr = true },
                        },
                    },
                },
                notifier = { enabled = true },
                picker = {
                    enabled = true,
                    formatters = { file = { filename_first = true } },
                    layout = function()
                        return {
                            preview = vim.o.lines >= 25,
                            layout = {
                                width = 0.8,
                                max_width = 160,
                                min_width = 0,
                                min_height = 0,
                                row = 1,
                                backdrop = true,
                            },
                            preset = vim.o.columns >= 120 and "default" or "vertical",
                        }
                    end,
                    win = {
                        input = {
                            keys = {
                                ["<Esc>"] = { "close", mode = { "n", "i" } },
                            },
                        },
                    },
                },
            })

            vim.keymap.set("n", "<Leader><Leader>", function()
                Snacks.picker.files({ hidden = true })
            end, { desc = "File picker" })
            vim.keymap.set("n", "<Leader>sg", Snacks.picker.grep, { desc = "Live grep" })
            vim.keymap.set("n", "<Leader>sh", Snacks.picker.help, { desc = "Search help tags" })
            vim.keymap.set("n", "<Leader>,", Snacks.picker.buffers, { desc = "Show open buffers" })
            vim.keymap.set("n", "<Leader>sd", Snacks.picker.diagnostics, { desc = "Show workspace diagnostics" })
            vim.keymap.set("n", "z=", Snacks.picker.spelling, { desc = "Show spell suggestions" })
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- TREE-SITTER
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        config = function()
            local ensure_installed = {
                "bash",
                "c",
                "cmake",
                "cpp",
                "css",
                "diff",
                "fish",
                "gitcommit",
                "gitignore",
                "html",
                "ini",
                "javascript",
                "jsdoc",
                "json",
                "kdl",
                "kitty",
                "lua",
                "luadoc",
                "markdown_inline",
                "nix",
                "powershell",
                "printf",
                "qmljs",
                "svelte",
                "toml",
                "typescript",
                "xml",
                "yaml",
                "zsh",
            }

            require("nvim-treesitter").install(ensure_installed)

            vim.api.nvim_create_autocmd("FileType", {
                desc = "Enable Treesitter when available",
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)

                    if not lang or not vim.treesitter.language.add(lang) then
                        return
                    end

                    vim.treesitter.start()

                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo.foldmethod = "expr"

                    if vim.treesitter.query.get(lang, "indents") then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
    -------------------------------------------------------------------------------------------------------------------
    -- LSP
    -------------------------------------------------------------------------------------------------------------------
    { src = "https://github.com/b0o/SchemaStore.nvim" },
    {
        src = "https://github.com/j-hui/fidget.nvim",
        event = "LspAttach",
        config = function()
            require("fidget").setup()
        end,
    },
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        config = function()
            local servers = {
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
                vim.fn.has("win32") == 1 and "powershell_es" or nil,
            }
            vim.lsp.enable(servers)
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- GUESS-INDENT.NVIM
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/NMAC427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup()
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- MINI.ICONS
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-mini/mini.icons",
        config = function()
            require("mini.icons").setup()
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- MINI.MOVE
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-mini/mini.move",
        config = function()
            require("mini.move").setup()
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- MINI.SPLITJOIN
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/nvim-mini/mini.splitjoin",
        config = function()
            require("mini.splitjoin").setup()
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- CANOLA.NVIM
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/barrettruth/canola.nvim",
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
            vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { noremap = true, desc = "Open Oil file manager" })
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- CONFORM.NVIM
    -------------------------------------------------------------------------------------------------------------------
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
                    svelte = { "prettierd" },
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
    -------------------------------------------------------------------------------------------------------------------
    -- GITSIGNS.NVIM
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/lewis6991/gitsigns.nvim",
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
                    map("n", "<Leader>hs", gitsigns.stage_hunk)
                    map("n", "<Leader>hr", gitsigns.reset_hunk)

                    map("v", "<Leader>hs", function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end)

                    map("v", "<Leader>hr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end)

                    map("n", "<Leader>hS", gitsigns.stage_buffer)
                    map("n", "<Leader>hR", gitsigns.reset_buffer)
                    map("n", "<Leader>hp", gitsigns.preview_hunk)
                    map("n", "<Leader>hi", gitsigns.preview_hunk_inline)

                    map("n", "<Leader>hb", function()
                        gitsigns.blame_line({ full = true })
                    end)

                    map("n", "<Leader>hd", gitsigns.diffthis)

                    map("n", "<Leader>hD", function()
                        gitsigns.diffthis("~")
                    end)

                    map("n", "<Leader>hQ", function()
                        gitsigns.setqflist("all")
                    end)
                    map("n", "<Leader>hq", gitsigns.setqflist)

                    -- Toggles
                    map("n", "<Leader>tb", gitsigns.toggle_current_line_blame)
                    map("n", "<Leader>tw", gitsigns.toggle_word_diff)

                    -- Text object
                    map({ "o", "x" }, "ih", gitsigns.select_hunk)
                end,
            })
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- MASON.NVIM
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/mason-org/mason-lspconfig.nvim",
        enabled = not Util.is_nixos,
    },
    {
        src = "https://github.com/mason-org/mason.nvim",
        enabled = not Util.is_nixos,
        config = function()
            require("mason").setup()

            local function sync_mason_tools()
                require("mason-lspconfig").setup({
                    automatic_enable = false,
                })

                local mr = require("mason-registry")
                mr.refresh(function()
                    local servers = vim.lsp._enabled_configs
                    local mappings = require("mason-lspconfig").get_mappings().lspconfig_to_package
                    local formatters_by_ft = require("conform").formatters_by_ft

                    local to_install = {
                        qmlls = false,
                        shellcheck = true,
                        shfmt = true,
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

                    for package_name, value in pairs(to_install) do
                        if value and not mr.is_installed(package_name) then
                            mr.get_package(package_name):install()
                        end
                    end
                end)
            end

            vim.api.nvim_create_user_command("Mason", function()
                sync_mason_tools()
                require("mason.api.command").Mason()
            end, {})

            vim.keymap.set("n", "<Leader>m", "<cmd>Mason<CR>", { desc = "Open Mason and sync required tools" })
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- BLINK.CMP
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("*"),
        event = { "InsertEnter", "CmdlineEnter" },
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

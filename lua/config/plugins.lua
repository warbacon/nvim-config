require("packy2").setup({
    -------------------------------------------------------------------------------------------------------------------
    -- PINO.NVIM
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/warbacon/pino.nvim",
        config = function()
            require("pino").setup({
                plugins = {
                    mini = true,
                    fzf_lua = true,
                    mason = not Util.is_nixos,
                    lazy = false,
                },
            })
            vim.cmd.colorscheme("pino")
        end,
    },
    -------------------------------------------------------------------------------------------------------------------
    -- TREE-SITTER
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/arborist-ts/arborist.nvim",
        config = function()
            require("arborist").setup({
                prefer_wasm = false,
                update_cadence = "manual",
                install_popular = false,
                ensure_installed = {
                    "bash",
                    "css",
                    "diff",
                    "html",
                    "ini",
                    "javascript",
                    "jsdoc",
                    "json",
                    "luadoc",
                    "markdown_inline",
                    "nix",
                    "toml",
                    "typescript",
                    "xml",
                    "yaml",
                },
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
        event = "VeryLazy",
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
    -- GITSIGNS.NVIM
    -------------------------------------------------------------------------------------------------------------------
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
    -- FZF-LUA
    -------------------------------------------------------------------------------------------------------------------
    {
        src = "https://github.com/ibhagwan/fzf-lua",
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
vim.keymap.set("n", "<Leader>r", undotree, { desc = "Undotree" })
vim.api.nvim_create_user_command("Undotree", undotree, {})

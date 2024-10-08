return {
    -- MINI.PICK ===============================================================
    {
        "echasnovski/mini.pick",
        dependencies = {
            { "echasnovski/mini.icons", opts = {} },
        },
        cmd = "Pick",
        keys = {
            { "<leader>,", "<cmd>Pick buffers<cr>", mode = "n" },
            { "<leader>f", "<cmd>Pick files<cr>", mode = "n" },
            { "<leader>sg", "<cmd>Pick grep_live<cr>", mode = "n" },
            { "<leader>sh", "<cmd>Pick help<cr>", mode = "n" },
            {
                "<leader>sd",
                function()
                    require("mini.extra").pickers.diagnostic()
                end,
                mode = "n",
            },
        },
        opts = {
            default_show = {
                show_icons = true,
            },
        },
    },

    -- OIL.NVIM ================================================================
    {
        "stevearc/oil.nvim",
        lazy = false,
        keys = {
            { "-", "<cmd>Oil<cr>", mode = "n" },
        },
        opts = {
            delete_to_trash = vim.fn.has("win32") == 0,
            skip_confirm_for_simple_edits = true,
            win_options = {
                colorcolumn = "",
            },
            keymaps = {
                ["`"] = false,
                ["cd"] = "actions.cd",
            },
        },
    },

    -- NVIM-HIGHLIGHT-COLORS ===================================================
    {
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            enable_named_colors = false,
            enable_tailwind = true,
            exclude_filetypes = {
                "lazy",
                "mason",
            },
        },
    },

    -- GITSIGNS ================================================================
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            attach_to_untracked = true,
            signs = {
                add = { text = "▍" },
                change = { text = "▍" },
                delete = { text = "" },
                topdelete = { text = "▔" },
                changedelete = { text = "▍" },
                untracked = { text = "▍" },
            },
            signs_staged = {
                add = { text = "▍" },
                change = { text = "▍" },
                delete = { text = "" },
                topdelete = { text = "▔" },
                changedelete = { text = "▍" },
                untracked = { text = "▍" },
            },
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
                map("n", "<leader>hu", gitsigns.undo_stage_hunk)
                map("n", "<leader>hR", gitsigns.reset_buffer)
                map("n", "<leader>hp", gitsigns.preview_hunk)
                map("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end)
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
                map("n", "<leader>hd", gitsigns.diffthis)
                map("n", "<leader>hD", function()
                    gitsigns.diffthis("~")
                end)
                map("n", "<leader>td", gitsigns.toggle_deleted)

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },
}

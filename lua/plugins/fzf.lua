return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "elanmed/fzf-lua-frecency.nvim",
    },
    event = "VeryLazy",
    keys = {
        { "<leader>,", "<cmd>FzfLua buffers<cr>" },
        {
            "<leader>f",
            function()
                if Util.is_win then
                    require("fzf-lua").files()
                else
                    ---@diagnostic disable-next-line: missing-fields
                    require("fzf-lua-frecency").frecency({
                        cwd_only = true,
                        display_score = false,
                    })
                end
            end,
        },
        { "<leader>sg", "<cmd>FzfLua live_grep<cr>" },
        { "<leader>sh", "<cmd>FzfLua helptags<cr>" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>" },
        { "z=", "<cmd>FzfLua spell_suggest<cr>" },
    },
    opts = {
        fzf_colors = true,
        defaults = {
            winopts = {
                preview = {
                    flip_columns = 120,
                    hidden = true,
                },
            },
        },
        lsp = {
            symbols = {
                symbol_icons = Util.icons.kinds,
            },
        },
        diagnostics = {
            diag_icons = Util.icons.signs,
        },
        keymap = {
            builtin = {
                ["<F1>"] = "toggle-help",
                ["<M-m>"] = "toggle-fullscreen",
                ["<M-p>"] = "toggle-preview",
            },
        },
    },
    config = function(_, opts)
        require("fzf-lua").setup(opts)
        require("fzf-lua").register_ui_select()
    end,
}

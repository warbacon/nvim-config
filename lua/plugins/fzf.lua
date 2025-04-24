return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    cmd = "FzfLua",
    keys = {
        { "<leader>,", "<cmd>FzfLua buffers<cr>" },
        { "<leader>f", "<cmd>FzfLua files<cr>" },
        { "<leader>sg", "<cmd>FzfLua live_grep<cr>" },
        { "<leader>sh", "<cmd>FzfLua helptags<cr>" },
        { "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>" },
        { "z=", "<cmd>FzfLua spell_suggest<cr>" },
        { "<c-p>", "<cmd>FzfLua builtin<cr>" },
    },
    opts = {
        fzf_colors = true,
        defaults = {
            file_icons = "mini",
            winopts = {
                preview = {
                    flip_columns = 120,
                },
            },
        },
        files = {
            git_icons = true,
            cwd_prompt = false,
        },
        lsp = {
            symbols = {
                symbol_icons = Util.icons.kinds,
            }
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

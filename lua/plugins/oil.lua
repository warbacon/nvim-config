return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "-", "<Cmd>Oil<CR>" },
    },
    ---@type oil.SetupOpts
    opts = {
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
    },
}

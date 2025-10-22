return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "-", "<Cmd>Oil<CR>" },
    },
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
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
    },
}

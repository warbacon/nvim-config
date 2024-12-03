return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "-", "<cmd>Oil<CR>" },
    },
    opts = {
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        lsp_file_methods = { autosave_changes = "unmodified" },
        keymaps = {
            ["`"] = false,
            [","] = "actions.cd",
        },
    },
}

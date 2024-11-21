return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "-", "<cmd>Oil<cr>" },
    },
    opts = {
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        lsp_file_methods = {
            autosave_changes = "unmodified",
        },
        watch_for_changes = true,
        keymaps = {
            ["`"] = false,
            [","] = "actions.cd",
        },
    },
}

return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        {
            "-",
            function()
                require("oil").open(nil, { preview = { vertical = true } })
            end,
        },
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

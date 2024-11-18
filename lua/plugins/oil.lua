return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "-", "<cmd>Oil<cr>" },
    },
    opts = {
        delete_to_trash = vim.fn.has("win32") == 0,
        skip_confirm_for_simple_edits = true,
        win_options = {
            colorcolumn = "",
        },
        keymaps = {
            ["`"] = false,
            [","] = "actions.cd",
        },
    },
}

return {
    "A7Lavinraj/fyler.nvim",
    branch = "stable",
    lazy = false,
    keys = {
        { "-", "<Cmd>Fyler<CR>" },
    },
    opts = {
        views = {
            finder = {
                default_explorer = true,
                confirm_simple = true,
                delete_to_trash = true,
                indentscope = {
                    enabled = false,
                },
                mappings = {
                    ["<C-c>"] = "CloseView",
                    ["<S-l>"] = "Select",
                    ["<C-t>"] = "SelectTab",
                    ["%"] = "SelectVSplit",
                    ['"'] = "SelectSplit",
                    ["-"] = "GotoParent",
                    ["_"] = "GotoCwd",
                    ["."] = "GotoNode",
                    ["#"] = "CollapseAll",
                    ["<S-h>"] = "CollapseNode",
                },
                win = {
                    win_opts = {
                        number = true,
                        relativenumber = true,
                        cursorline = true
                    },
                },
            },
        },
    },
}

return {
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {},
    },
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.splitjoin",
        keys = "gs",
        opts = {
            mappings = { toggle = "gs" },
        },
    },
    {
        "echasnovski/mini.move",
        keys = {
            { "<M-h>", mode = { "n", "v" } },
            { "<M-j>", mode = { "n", "v" } },
            { "<M-k>", mode = { "n", "v" } },
            { "<M-l>", mode = { "n", "v" } },
        },
        opts = {},
    },
    {
        "echasnovski/mini.files",
        lazy = false,
        keys = {
            {
                "<leader>e",
                function()
                    require("mini.files").open()
                end,
            },
        },
        opts = {
            content = {
                filter = function(fs_entry)
                    return fs_entry.name ~= ".git" or fs_entry.fs_type ~= "directory"
                end,
            },
            windows = {
                preview = true,
                width_focus = 25,
                width_preview = 60,
            },
        },
    },
}

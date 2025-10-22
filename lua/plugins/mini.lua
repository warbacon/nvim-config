return {
    {
        "nvim-mini/mini.icons",
        priority = 1000,
        opts = {},
    },
    {
        "nvim-mini/mini.misc",
        event = "VeryLazy",
        config = function()
            require("mini.misc").setup_termbg_sync()
        end,
    },
    {
        "nvim-mini/mini.move",
        keys = {
            { "<A-k>", mode = { "n", "v" } },
            { "<A-j>", mode = { "n", "v" } },
            { "<A-h>", mode = { "n", "v" } },
            { "<A-l>", mode = { "n", "v" } },
        },
        opts = {},
    },
    {
        "nvim-mini/mini.splitjoin",
        keys = {
            { "gs", mode = { "n", "v" } },
        },
        opts = {
            mappings = {
                toggle = "gs",
            },
        },
    },
}

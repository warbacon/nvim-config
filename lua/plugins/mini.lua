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
            { "<A-k>" },
            { "<A-j>" },
            { "<A-h>" },
            { "<A-l>" },
        },
        opts = {},
    },
    {
        "nvim-mini/mini.splitjoin",
        keys = { "gs" },
        opts = {
            mappings = {
                toggle = "gs",
            },
        },
    },
}

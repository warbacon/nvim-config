return {
    {
        "echasnovski/mini.icons",
        opts = {
            filetype = {
                kitty = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
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
}

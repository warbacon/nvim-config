return {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    main = "ibl",
    opts = {
        indent = {
            char = "▏",
            tab_char = "▏",
        },
        scope = {
            show_start = false,
            show_end = false
        },
    },
}

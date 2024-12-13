return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "LazyFile",
    opts = {
        indent = {
            char = "▏",
        },
        scope = {
            show_start = false,
            show_end = false,
        }
    },
}

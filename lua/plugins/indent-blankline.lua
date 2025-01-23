return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "LazyFile",
    opts = {
        exclude = {
            filetypes = {
                "snacks_picker_preview",
            },
        },
        indent = {
            char = "▏",
        },
        scope = {
            show_start = false,
            show_end = false,
        },
    },
}

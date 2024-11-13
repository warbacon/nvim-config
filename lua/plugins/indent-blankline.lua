return {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        indent = {
            char = "▏",
            tab_char = "▏",
        },
        scope = { show_start = false, show_end = false },
        exclude = {
            filetypes = {
                "help",
                "lazy",
                "mason",
                "snacks_notif",
                "snacks_terminal",
                "snacks_win",
            },
        },
    },
}

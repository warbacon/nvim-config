return {
    "nvimdev/indentmini.nvim",
    event= "LazyFile",
    opts = {
        char = "▏",
        exclude = {
            "help",
            "lazy",
            "mason",
            "snacks_notif",
        },
    },
}

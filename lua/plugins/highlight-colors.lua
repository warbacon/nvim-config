return {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
        enable_named_colors = false,
        enable_tailwind = true,
        exclude_filetypes = {
            "lazy",
            "mason",
            "snacks_notif",
            "snacks_terminal",
            "snacks_win",
        },
    },
    config = function(_, opts)
        require("nvim-highlight-colors").setup(opts)
        require("nvim-highlight-colors").turnOn()
    end,
}

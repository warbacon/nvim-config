return {
    "folke/snacks.nvim",
    version = "*",
    priority = 1000,
    lazy = false,
    keys = {
        {
            "<leader>n",
            function()
                Snacks.notifier.show_history()
            end,
        },
    },
    opts = {
        notifier = { enabled = true },
        quickfile = { enabled = true },
    },
}

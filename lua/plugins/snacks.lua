return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        -- stylua: ignore start
        { "<leader>n", function() Snacks.notifier.show_history() end },
        -- stylua: ignore end
    },
    opts = {
        notifier = { enabled = true },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        input = { enabled = true },
        indent = {
            enabled = false,
            indent = {
                char = "▏",
            },
            scope = {
                char = "▏",
                only_current = true,
            },
        },
    },
}

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        -- stylua: ignore start
        { "<leader>gB", function() Snacks.gitbrowse() end },
        { "<leader>n", function() Snacks.notifier.show_history() end },
        -- stylua: ignore end
    },
    opts = {
        notifier = { enabled = true },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        indent = {
            char = "▏",
            enabled = true,
        },
    },
}

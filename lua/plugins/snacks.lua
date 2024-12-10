return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        -- stylua: ignore start
        { "<leader>gB", function() Snacks.gitbrowse() end },
        { "<leader>n", function() Snacks.notifier.show_history() end },
        { "<leader>z",  function() Snacks.zen() end },
        -- stylua: ignore end
    },
    opts = {
        notifier = { enabled = true },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        indent = {
            enabled = true,
            indent = {
                char = "▏",
            },
            scope = {
                animate = {
                    enabled = false,
                },
                char = "▏",
                only_current = true,
            },
        },
    },
}

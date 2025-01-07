return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    priority = 45,
    opts = {
        provider = "copilot",
        auto_suggestions_provider = "copilot",
        windows = {
            sidebar_header = {
                rounded = false,
            },
            input = {
                prefix = "❯ ",
            },
        },
    },
    build = util.is_win and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
    dependencies = {
        { "zbirenbaum/copilot.lua", opts = {} },
    },
}

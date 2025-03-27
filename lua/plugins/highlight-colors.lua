return {
    "brenoprata10/nvim-highlight-colors",
    event = "LazyFile",
    opts = {
        enable_short_hex = false,
        enable_hsl_without_function = false,
        enable_named_colors = false,
        enable_tailwind = true,
        exclude_filetypes = { "lazy" },
    },
    config = function(_, opts)
        vim.defer_fn(function()
            require("nvim-highlight-colors").setup(opts)
            require("nvim-highlight-colors").turnOn()
        end, 100)
    end,
}

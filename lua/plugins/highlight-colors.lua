return {
    "brenoprata10/nvim-highlight-colors",
    event = "LazyFile",
    opts = {
        enable_hsl_without_function = false,
        enable_var_usage = false,
        enable_named_colors = false,
        enable_tailwind = true,
        enable_ansi = false,
        exclude_filetypes = { "lazy" },
        exclude_buftypes = { "nofile" },
    },
    config = function(_, opts)
        vim.defer_fn(function()
            require("nvim-highlight-colors").setup(opts)
            require("nvim-highlight-colors").turnOn()
        end, 100)
    end,
}

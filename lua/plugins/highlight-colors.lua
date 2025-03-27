return {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
        enable_short_hex = false,
        enable_hsl_without_function = false,
        enable_named_colors = false,
        enable_tailwind = true,
        exclude_filetypes = { "lazy" },
    },
}

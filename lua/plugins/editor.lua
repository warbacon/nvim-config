return {
    -- TELESCOPE.NVIM ==========================================================
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                selection_caret = "  ",
                prompt_prefix = "   ",
                path_display = {
                    filename_first = {
                        reverse_directories = false,
                    },
                },
            },
        },
    },
}

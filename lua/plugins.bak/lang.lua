return {
    -- VIM-KITTY ===============================================================
    {
        "warbacon/vim-kitty",
        ft = "kitty",
    },

    -- MARKDOWN-PREVIEW ========================================================
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}

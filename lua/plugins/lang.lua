return {
    -- VIM-KITTY ===============================================================
    {
        "warbacon/vim-kitty",
        ft = "kitty",
        enabled = vim.fn.executable("kitty") == 1,
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

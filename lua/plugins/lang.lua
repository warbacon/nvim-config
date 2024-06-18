return {
    -- MARKDOWN-PREVIEW.NVIM ===================================================
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- VIM-KITTY ===============================================================
    {
        "fladson/vim-kitty",
        ft = "kitty",
        enabled = vim.uv.fs_stat(vim.env.HOME .. "/.config/kitty") ~= nil,
    },
}

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

    -- MARKDOWN.NVIM ===========================================================
    {
        "MeanderingProgrammer/markdown.nvim",
        main = "render-markdown",
        ft = "markdown",
        opts = {
            file_types = { "markdown" },
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            heading = {
                sign = false,
                icons = {},
            },
        },
    },

    -- VIM-KITTY ===============================================================
    {
        "fladson/vim-kitty",
        ft = "kitty",
        enabled = vim.uv.fs_stat(vim.env.HOME .. "/.config/kitty") ~= nil,
    },
}

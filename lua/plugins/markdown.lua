return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function()
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.cmd([[do FileType]])
        end,
    },
    {
        "bullets-vim/bullets.vim",
        ft = "markdown",
        config = function()
            vim.g.bullets_enabled_file_types = { "markdown" }
        end,
    },
}

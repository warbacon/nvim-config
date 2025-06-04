return {
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.fn["mkdp#util#install"]()
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

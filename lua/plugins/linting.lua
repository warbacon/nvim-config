return {
    -- NVIM-LINT ===============================================================
    "mfussenegger/nvim-lint",
    config = function()
        require("lint").linters_by_ft = {
            fish = { "fish" },
            markdown = { "markdownlint" },
            zsh = { "zsh" },
        }

        require("lint").linters.markdownlint.args = { "--disable=MD033" }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}

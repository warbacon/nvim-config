return {
    -- NVIM-LINT ---------------------------------------------------------------
    "mfussenegger/nvim-lint",
    dependencies = "mason.nvim",
    event = "LazyFile",
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            fish = { "fish" },
            markdown = { "markdownlint" },
            zsh = { "zsh" },
        }

        lint.linters.markdownlint.args = { "--disable=MD033" }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = function()
                local timer = vim.uv.new_timer()
                timer:start(100, 0, function()
                    timer:stop()
                    vim.schedule_wrap(lint.try_lint)()
                end)
                return timer
            end,
        })
    end,
}

return {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    config = function()
        require("lint").linters_by_ft = {
            fish = { "fish" },
            markdown = { "markdownlint" },
            zsh = { "zsh" },
        }

        require("lint").linters.markdownlint.args = { "--disable=MD033" }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = function(ev)
                if ev.event == "BufReadPost" then
                    local timer = vim.uv.new_timer()
                    timer:start(100, 0, function()
                        timer:stop()
                        vim.schedule_wrap(require("lint").try_lint)()
                    end)
                    return timer
                else
                    require("lint").try_lint()
                end
            end,
        })
    end,
}

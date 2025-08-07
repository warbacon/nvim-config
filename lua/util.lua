local M = {}

vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    callback = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
    end,
})

---@param func function
function M.later(func)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
            vim.schedule(func)
        end,
    })
end

return M

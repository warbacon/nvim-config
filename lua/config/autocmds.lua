-- Remove traling whitespace and new lines on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        -- Save cursor position to later restore
        local curpos = vim.api.nvim_win_get_cursor(0)
        -- Search and replace trailing whitespace
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, curpos)

        -- Remove new lines
        local n_lines = vim.api.nvim_buf_line_count(0)
        local last_nonblank = vim.fn.prevnonblank(n_lines)
        if last_nonblank + 1 < n_lines then
            vim.api.nvim_buf_set_lines(0, last_nonblank + 1, n_lines, true, {})
        end
    end,
})

-- Fix cursor at leave
vim.api.nvim_create_autocmd("VimLeave", {
    command = [[set guicursor= | call chansend(v:stderr, "\x1b[ q")]],
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

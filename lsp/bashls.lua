---@type vim.lsp.Config
return {
    on_attach = function(client, bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local basename = vim.fn.fnamemodify(filename, ":t")
        if basename:match("^%.env") then
            ---@diagnostic disable-next-line: missing-parameter
            client.stop()
        end
    end,
}

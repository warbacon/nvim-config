---@type vim.lsp.Config
return {
    on_attach = function(client, bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        if string.match(filename, "/waybar/.*%.css$") then
            ---@diagnostic disable-next-line: missing-parameter
            client.stop()
        end
    end,
}

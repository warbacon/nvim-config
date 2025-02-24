---@type vim.lsp.Config
return {
    cmd = { "clangd" },
    filetypes = { "c", "cpp" },
    root_dir = require("lspconfig.configs.clangd").default_config.root_dir(vim.api.nvim_buf_get_name(0)),
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { "utf-8", "utf-16" },
    },
}

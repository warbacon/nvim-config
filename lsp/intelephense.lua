---@type vim.lsp.Config
return {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_dir = require("lspconfig.configs.intelephense").default_config.root_dir(vim.api.nvim_buf_get_name(0)),
    init_options = {
        globalStoragePath = vim.fn.stdpath("data"),
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 1000000,
            },
        },
    },
}

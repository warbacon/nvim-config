---@type vim.lsp.Config
return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_dir = require("lspconfig.configs.bashls").default_config.root_dir(vim.api.nvim_buf_get_name(0)),
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
        },
    },
}

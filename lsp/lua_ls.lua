---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_dir = require("lspconfig.configs.lua_ls").default_config.root_dir(vim.api.nvim_buf_get_name(0)),
}

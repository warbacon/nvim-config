---@type vim.lsp.Config
return {
    filetypes = { "yaml" },
    settings = {
        yaml = {
            schemaStore = { enable = false, url = "" },
        },
    },
    before_init = function(_, config)
        config.settings.yaml.schemas = require("schemastore").yaml.schemas()
    end
}

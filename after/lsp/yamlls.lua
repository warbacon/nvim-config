---@type vim.lsp.Config
return {
    settings = {
        yaml = {
            schemaStore = {
                enable = false,
                url = "",
            },
        },
    },
    before_init = function(_, config)
        config.settings.yaml.schemas =
            vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
    end,
}

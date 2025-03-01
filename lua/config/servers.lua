return {
    astro = {},
    basedpyright = {},
    bashls = {},
    clangd = {},
    intelephense = {
        init_options = {
            globalStoragePath = vim.fn.stdpath("data"),
        },
    },
    jsonls = {
        on_new_config = function(new_config)
            new_config.settings.json.schemas = require("schemastore").json.schemas()
        end,
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
            },
        },
    },
    powershell_es = { autostart = false },
    yamlls = {
        on_new_config = function(new_config)
            new_config.settings.yaml.schemas = require("schemastore").yaml.schemas()
        end,
        settings = { yaml = { schemaStore = { enable = false, url = "" } } },
    },
}

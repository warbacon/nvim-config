local M = {}

M.servers = {
    astro = {},
    basedpyright = {},
    bashls = {},
    clangd = vim.fn.has("win32") == 0 and {} or nil,
    cssls = {
        settings = {
            css = {
                lint = { unknownAtRules = "ignore" },
            },
        },
    },
    dockerls = {},
    jdtls = vim.fn.executable("java") == 1 and {} or nil,
    jsonls = {
        on_new_config = function(new_config)
            new_config.settings.json.schemas = require("schemastore").json.schemas()
        end,
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                completion = { callSnippet = "Replace" },
            },
        },
    },
    powershell_es = vim.fn.executable("pwsh") == 1 and {
        settings = {
            powershell = {
                codeFormatting = { preset = "Stroustrup" },
            },
        },
    } or nil,
    svelte = {},
    tailwindcss = {
        filetypes = { "astro", "html", "css", "svelte" },
    },
    vtsls = {
        settings = {
            typescript = {
                updateImportsOnFileMove = "always",
                suggest = {
                    completeFunctionCalls = true,
                },
            },
            javascript = {
                updateImportsOnFileMove = "always",
            },
            vtsls = {
                enableMoveToFileCodeAction = true,
            },
        },
    },
    yamlls = {
        on_new_config = function(new_config)
            new_config.settings.yaml.schemas = require("schemastore").yaml.schemas()
        end,
        settings = {
            yaml = {
                schemaStore = { enable = false, url = "" },
            },
        },
    },
}

return M

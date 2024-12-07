return {
    astro = {},
    basedpyright = {},
    bashls = {},
    clangd = not vim.uv.os_uname().sysname:find("Windows") ~= nil and {} or nil,
    cssls = {
        on_attach = function(client, bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            if string.match(filename, "/waybar/.*%.css$") then
                client.stop()
            end
        end,
        settings = {
            css = {
                lint = { unknownAtRules = "ignore" },
            },
        },
    },
    emmet_language_server = {},
    dockerls = {},
    html = {},
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
        filetypes = { "astro", "svelte" },
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

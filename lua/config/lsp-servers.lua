return {
    astro = {},
    basedpyright = {},
    bashls = {},
    clangd = not Util.is_win and {} or nil,
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
    svelte = {
        capabilities = {
            workspace = {
                didChangeWatchedFiles = { dynamicRegistration = true },
            },
        },
    },
    tailwindcss = {
        filetypes = { "astro", "css", "html", "svelte" },
    },
    vtsls = {
        settings = {
            complete_function_calls = true,
            vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                tsserver = {
                    globalPlugins = {
                        {
                            name = "typescript-svelte-plugin",
                            location = Util.get_pkg_path(
                                "svelte-language-server",
                                "/node_modules/typescript-svelte-plugin"
                            ),
                            enableForWorkspaceTypeScriptVersions = true,
                        },
                        {
                            name = "@astrojs/ts-plugin",
                            location = Util.get_pkg_path("astro-language-server", "/node_modules/@astrojs/ts-plugin"),
                            enableForWorkspaceTypeScriptVersions = true,
                        },
                    },
                },
            },
            typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                    completeFunctionCalls = true,
                },
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

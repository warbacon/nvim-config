---@type table<string, vim.lsp.Config>
vim.g.lsp_servers = {
    astro = {},
    basedpyright = {},
    bashls = {
        on_attach = function(client, bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            local basename = vim.fn.fnamemodify(filename, ":t")
            if basename:match("^%.env") then
                ---@diagnostic disable-next-line: missing-parameter
                client.stop()
            end
        end,
    },
    clangd = {},
    cssls = {
        on_attach = function(client, bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            if string.match(filename, "/waybar/.*%.css$") then
                ---@diagnostic disable-next-line: missing-parameter
                client.stop()
            end
        end,
    },
    emmet_language_server = {},
    html = {},
    jsonls = {
        before_init = function(_, config)
            config.settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                },
            }
        end,
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
            },
        },
    },
    nixd = {},
    svelte = {},
    tailwindcss = {},
    -- tsgo = {
    --     cmd = { "tsgo", "--lsp", "--stdio" },
    --     filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    -- },
    vtsls = {},
    yamlls = {
        settings = {
            yaml = {
                schemaStore = { enable = false, url = "" },
            },
        },
        before_init = function(_, config)
            ---@diagnostic disable-next-line: inject-field
            config.settings.yaml.schemas = require("schemastore").yaml.schemas()
        end,
    },
}

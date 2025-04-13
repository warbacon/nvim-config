return {
    astro = {},
    basedpyright = {},
    bashls = {},
    clangd = {},
    cssls = {
        on_attach = function(client, bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            if string.match(filename, "/waybar/.*%.css$") then
                client.stop()
            end
        end,
    },
    docker_compose_language_service = {},
    dockerls = {},
    emmet_language_server = {
        filetypes = { "css", "html", "php" },
    },
    html = {},
    phpactor = {},
    -- intelephense = {
    --     init_options = { globalStoragePath = vim.fn.stdpath("data") },
    -- },
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
            },
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
            },
        },
    },
    powershell_es = { autostart = false },
    tailwindcss = {
        filetypes = { "css", "html", "astro" },
    },
    vtsls = {},
    yamlls = {
        filetypes = { "yaml" },
        settings = {
            yaml = {
                schemas = require("schemastore").yaml.schemas(),
                schemaStore = { enable = false, url = "" },
            },
        },
    },
}

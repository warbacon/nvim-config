local M = {}

M.is_win = vim.uv.os_uname().sysname:find("Windows") ~= nil
M.is_lin = vim.uv.os_uname().sysname:find("Linux") ~= nil

M.icons = {
    indent = "▏",
    signs = { "", "", "", "" },
    kinds = {
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Keyword = "",
        Method = "",
        Module = "",
        Operator = "",
        Property = "",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "",
    },
}

---@type table<string, vim.lsp.Config>
M.lsp_servers = {
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
    docker_compose_language_service = {},
    dockerls = {},
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
    vtsls = {},
    yamls = {
        filetypes = { "yaml" },
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

return M

return {
    "williamboman/mason.nvim",
    branch = "v2.x",
    build = ":MasonUpdate",
    event = { "LazyFile", "VeryLazy" },
    keys = {
        { "<leader>m", "<cmd>Mason<cr>" },
    },
    opts = {
        ui = {
            icons = {
                package_pending = " ",
                package_installed = " ",
                package_uninstalled = " ",
            },
            height = 0.8,
        },
        ensure_installed = {
            "bash-language-server",
            "clangd",
            "json-lsp",
            "lua-language-server",
            "shellcheck",
            "stylua",
            "yaml-language-server",
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)

        local ensure_installed = opts.ensure_installed

        local registry = require("mason-registry")

        local function install_package(pkg_name)
            if registry.is_installed(pkg_name) then
                return
            end

            local pkg = registry.get_package(pkg_name)
            pkg:install({}, function(success)
                if not success then
                    return
                end
                -- Trigger FileType event to possibly load this newly installed LSP server
                vim.defer_fn(function()
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)
        end

        -- Refresh the registry and install any missing packages
        registry.refresh(function()
            for _, pkg_name in ipairs(ensure_installed) do
                install_package(pkg_name)
            end
        end)
    end,
}

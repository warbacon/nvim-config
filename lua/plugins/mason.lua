return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    event = { "LazyFile", "VeryLazy" },
    keys = {
        { "<leader>m", "<cmd>Mason<cr>" },
    },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
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
            "shellcheck",
            "stylua",
            "markdownlint",
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)
        require("mason-lspconfig").setup()

        local ensure_installed = vim.list_extend(opts.ensure_installed, vim.tbl_keys(require("config.servers")))
        local registry = require("mason-registry")

        registry:on("package:install:success", function()
            -- Trigger FileType event to possibly load this newly installed LSP server
            vim.defer_fn(function()
                require("lazy.core.handler.event").trigger({
                    event = "FileType",
                    buf = vim.api.nvim_get_current_buf(),
                })
            end, 100)
        end)

        -- Refresh the registry and install any missing packages
        registry.refresh(function()
            for _, pkg_name in ipairs(ensure_installed) do
                pkg_name = require("mason-lspconfig.mappings.server").lspconfig_to_package[pkg_name] or pkg_name
                if not registry.is_installed(pkg_name) then
                    registry.get_package(pkg_name):install()
                end
            end
        end)
    end,
}

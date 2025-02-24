return {
    "TheLeoP/powershell.nvim",
    ft = "ps1",
    opts = function()
        return {
            bundle_path = vim.env.MASON .. "/packages/powershell-editor-services",
            capabilities = vim.lsp.config.capabilities,
            settings = {
                powershell = {
                    codeFormatting = { preset = "Stroustrup" },
                },
            },
        }
    end,
}

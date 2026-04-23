local data_path = vim.fn.stdpath("data")
---@cast data_path string

---@type vim.lsp.Config
return {
    bundle_path = vim.fs.joinpath(data_path, "mason", "packages", "powershell-editor-services"),
    settings = {
        powershell = {
            codeFormatting = {
                preset = "Stroustrup",
            },
        },
    },
}

---@type vim.lsp.Config
return {
    settings = {
        java = {
            project = {
                referencedLibraries = {
                    vim.env.MPJ_HOME and vim.env.MPJ_HOME .. "/lib/*.jar" or nil,
                },
            },
        },
    },
}

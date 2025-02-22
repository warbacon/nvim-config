return {
    cmd = { "clangd" },
    filetypes = { "c", "cpp" },
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { "utf-8", "utf-16" },
    },
}

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
})

vim.lsp.enable({
    "astro",
    "basedpyright",
    "bashls",
    "clangd",
    "cssls",
    "emmet_language_server",
    "html",
    "jsonls",
    "lua_ls",
    "nixd",
    "svelte",
    "tailwindcss",
    "vtsls",
    "yamlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
        vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = args.buf })

        if client and client:supports_method("textDocument/documentColor") then
            vim.lsp.document_color.enable(true, args.buf)
        end
    end,
})

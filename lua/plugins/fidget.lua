return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
        progress = {
            display = {
                render_limit = 5,
                done_ttl = 2,
            },
        },
        notification = {
            window = {
                winblend = 20,
            },
        },
    },
}
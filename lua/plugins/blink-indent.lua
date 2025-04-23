return {
    "saghen/blink.nvim",
    name = "blink.indent",
    event = "LazyFile",
    opts = {
        indent = {
            enabled = true,
            static = {
                char = "▏",
                highlights = { "IblIndent" },
            },
            scope = {
                char = "▏",
                highlights = { "IblScope" },
            },
        },
    },
}

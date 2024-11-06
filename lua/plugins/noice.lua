return {
    "folke/noice.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.cmdheight = 0
    end,
    opts = {
        views = {
            popupmenu = {
                size = {
                    max_height = vim.o.pumheight,
                },
            },
        },
        cmdline = {
            view = "cmdline",
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            signature = {
                enabled = false,
            },
        },
        presets = {
            bottom_search = true,
            long_message_to_split = true,
        },
    },
    config = function(_, opts)
        if vim.o.filetype == "lazy" then
            vim.cmd([[messages clear]])
        end
        require("noice").setup(opts)
    end,
}

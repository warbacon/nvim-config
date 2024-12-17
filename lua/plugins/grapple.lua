return {
    "cbochs/grapple.nvim",
    event = "LazyFile",
    cmd = "Grapple",
    keys = {
        {
            "<leader>m",
            function()
                require("grapple").toggle()
                vim.cmd("redrawstatus")
            end,
        },
        { "<leader>M", "<cmd>Grapple toggle_tags<cr>" },
        { "<leader>n", "<cmd>Grapple cycle_tags next<cr>" },
        { "<leader>p", "<cmd>Grapple cycle_tags prev<cr>" },
    },
    opts = {
        scope = "git",
        statusline = {
            include_icon = false,
        },
    },
}

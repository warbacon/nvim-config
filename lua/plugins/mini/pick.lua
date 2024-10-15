local M = {}

M = {
    "echasnovski/mini.pick",
    dependencies = {
        "mini.icons",
    },
    cmd = "Pick",
    keys = {
        { "<leader>,", "<cmd>Pick buffers<cr>", mode = "n" },
        { "<leader>f", "<cmd>Pick files<cr>", mode = "n" },
        { "<leader>sg", "<cmd>Pick grep_live<cr>", mode = "n" },
        { "<leader>sh", "<cmd>Pick help<cr>", mode = "n" },
        {
            "<leader>sd",
            function()
                require("mini.extra").pickers.diagnostic()
            end,
            mode = "n",
        },
    },
    opts = {
        options = {
            use_cache = true,
        },
    },
    config = function(_, opts)
        require("mini.pick").setup(opts)
    end,
}

return M

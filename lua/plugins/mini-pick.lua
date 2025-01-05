return {
    "echasnovski/mini.pick",
    dependencies = {
        { "echasnovski/mini.extra", opts = {} },
    },
    cmd = "Pick",
    keys = {
        { "<leader>,", "<cmd>Pick buffers<CR>" },
        { "<leader>f", "<cmd>Pick files<CR>" },
        { "<leader>sg", "<cmd>Pick grep_live<CR>" },
        { "<leader>sh", "<cmd>Pick help<CR>" },
        { "<leader>sd", "<cmd>Pick diagnostic<CR>" },
    },
    opts = {
        options = {
            use_cache = true,
        },
    },
}

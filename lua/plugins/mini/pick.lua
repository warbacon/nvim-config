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

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function()
                vim.keymap.set("n", "gd", function()
                    require("mini.extra").pickers.lsp({ scope = "definition" })
                end)
                vim.keymap.set("n", "gD", function()
                    require("mini.extra").pickers.lsp({ scope = "type_definition" })
                end)
                vim.keymap.set("n", "gr", function()
                    require("mini.extra").pickers.lsp({ scope = "references" })
                end)
            end,
        })
    end,
}

return M

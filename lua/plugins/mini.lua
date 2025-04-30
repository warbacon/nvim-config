return {
    {
        "echasnovski/mini.icons",
        lazy = true,
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    {
        "echasnovski/mini.splitjoin",
        keys = { "gs" },
        opts = {
            mappings = {
                toggle = "gs",
            },
        },
    },
    {
        "echasnovski/mini.move",
        keys = {
            { "<A-h>", mode = { "n", "v" } },
            { "<A-j>", mode = { "n", "v" } },
            { "<A-k>", mode = { "n", "v" } },
            { "<A-l>", mode = { "n", "v" } },
        },
        opts = {},
    },
    {
        "echasnovski/mini.files",
        lazy = false,
        keys = {
            {
                "<leader>e",
                function()
                    require("mini.files").open()
                end,
            },
        },
        opts = {
            mappings = {
                go_in = "L",
                go_in_plus = "l",
                go_out = "H",
                go_out_plus = "h",
            },
        },
    },
}

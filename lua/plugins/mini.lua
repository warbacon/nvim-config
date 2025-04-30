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
                    pcall(MiniFiles.open, vim.api.nvim_buf_get_name(0), false)
                    MiniFiles.reveal_cwd()
                end,
            },
            {
                "<leader>E",
                function()
                    MiniFiles.open(nil, false)
                end,
            },
        },
        opts = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    Snacks.rename.on_rename_file(event.data.from, event.data.to)
                end,
            })

            return {
                windows = {
                    preview = true,
                    width_focus = 30,
                    width_preview = 60,
                },
                mappings = {
                    go_in = "L",
                    go_in_plus = "l",
                    go_out = "H",
                    go_out_plus = "h",
                },
            }
        end,
    },
}

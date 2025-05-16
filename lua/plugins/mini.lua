return {
    {
        "echasnovski/mini.icons",
        opts = {},
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
                    pcall(MiniFiles.open, vim.api.nvim_buf_get_name(0), true)
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
        opts = {
            content = {
                filter = function(fs_entry)
                    return not (fs_entry.fs_type == "directory" and fs_entry.name == ".git")
                end,
            },
            windows = {
                preview = true,
                width_focus = 30,
                width_preview = 40,
            },
            mappings = {
                go_in = "L",
                go_in_plus = "l",
                go_out = "H",
                go_out_plus = "h",
                change_cwd = ",",
            },
        },
        config = function(_, opts)
            require("mini.files").setup(opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    Snacks.rename.on_rename_file(event.data.from, event.data.to)
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    vim.keymap.set("n", opts.mappings and opts.mappings.change_cwd, function()
                        local cur_entry_path = MiniFiles.get_fs_entry().path
                        local cur_directory = vim.fs.dirname(cur_entry_path)
                        if cur_directory ~= nil then
                            vim.fn.chdir(cur_directory)
                            vim.notify("cwd: " .. vim.fn.fnamemodify(cur_directory, ":~"), "info", {
                                title = "MiniFiles",
                            })
                        end
                    end, { buffer = args.data.buf_id })
                end,
            })
        end,
    },
}

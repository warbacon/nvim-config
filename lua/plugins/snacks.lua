---@diagnostic disable: missing-fields
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        {
            "<leader>n",
            function()
                Snacks.notifier.show_history()
            end,
        },
    },
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
        notifier = {},
        image = {
            formats = {
                "png",
                "jpg",
                "jpeg",
                "gif",
                "bmp",
                "webp",
                "tiff",
                "heic",
                "avif",
                "mp4",
                "mov",
                "avi",
                "mkv",
                "webm",
            },
            doc = {
                inline = false,
                max_width = 60,
            },
            convert = { notify = false },
            math = { enabled = false },
        },
    },
}

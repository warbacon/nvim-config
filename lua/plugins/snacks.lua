return {
    "folke/snacks.nvim",
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
        scope = {
            treesitter = {
                enabled = false,
            },
        },
        indent = {
            indent = { char = "▏" },
            scope = { char = "▏" },
        },
        input = {},
    },
}

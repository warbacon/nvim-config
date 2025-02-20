return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        filetypes = { "*", "!lazy" },
        lazy_load = true,
        user_commands = false,
        user_default_options = {
            RGB = false,
            RGBA = false,
            RRGGBBAA = true,
            hsl_fn = true,
            names = false,
            rgb_fn = true,
            tailwind = true,
            mode = "virtualtext",
            virtualtext_inline = "before",
        },
    },
}

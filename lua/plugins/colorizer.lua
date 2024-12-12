return {
    "catgoose/nvim-colorizer.lua",
    event = "LazyFile",
    opts = {
        filetypes = { "*", "!lazy" },
        user_default_options = {
            names = false,
            RRGGBBAA = true,
            rgb_fn = true,
            hsl_fn = true,
            tailwind = true,
        },
        user_commands = false,
    },
}

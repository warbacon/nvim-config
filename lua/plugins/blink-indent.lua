return {
    "saghen/blink.indent",
    --- @module "blink.indent"
    --- @type blink.indent.Config
    opts = {
        static = {
            char = Util.icons.indent,
        },
        scope = {
            char = Util.icons.indent,
            highlights = { "BlinkIndentScope" },
        },
    },
}

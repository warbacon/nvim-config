return {
    "echasnovski/mini.diff",
    event = "LazyFile",
    keys = {
        -- stylua: ignore
        { "<leader>hp", function() require("mini.diff").toggle_overlay(0) end },
    },
    opts = {
        view = { style = "sign" },
    },
}
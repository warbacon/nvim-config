return {
    "echasnovski/mini.diff",
    event = "LazyFile",
    keys = {
        {
            "<leader>go",
            function()
                local overlay_enabled = vim.b.minidiff_overlay_enabled or false
                require("mini.diff").toggle_overlay(0)
                vim.b.minidiff_overlay_enabled = not overlay_enabled
                vim.notify(
                    overlay_enabled and "Overlay disabled!" or "Overlay enabled!",
                    vim.log.levels.INFO,
                    { title = "mini.diff" }
                )
            end,
        },
    },
    opts = {
        view = { style = "sign" },
    },
}

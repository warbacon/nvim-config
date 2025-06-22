return {
    "nvzone/showkeys",
    enabled = false,
    cmd = "ShowkeysToggle",
    keys = {
        {
            "<leader>k",
            function()
                require("showkeys").toggle()
                vim.g.showkeys_enabled = not vim.g.showkeys_enabled
                vim.notify(
                    "`showkeys` " .. (vim.g.showkeys_enabled and "enabled!" or "disabled!"),
                    vim.log.levels.INFO,
                    { title = "Miovim", id = "showkeys" }
                )
            end,
        },
    },
    init = function()
        vim.g.showkeys_enabled = false
    end,
    opts = {
        maxkeys = 5,
        show_count = true,
    },
}

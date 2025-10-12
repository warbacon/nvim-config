--
-- ███    ███ ██  ██████  ██    ██ ██ ███    ███
-- ████  ████ ██ ██    ██ ██    ██ ██ ████  ████
-- ██ ████ ██ ██ ██    ██ ██    ██ ██ ██ ████ ██
-- ██  ██  ██ ██ ██    ██  ██  ██  ██ ██  ██  ██
-- ██      ██ ██  ██████    ████   ██ ██      ██
--
-- Made by Warbacon
-- https://github.com/warbacon/nvim-config

if vim.fn.has("nvim-0.11") == 0 then
    vim.schedule(function()
        local v = vim.version()
        local msg = string.format(
            "This config requires Neovim v0.11.x or higher. You have v%d.%d.%d.",
            v.major,
            v.minor,
            v.patch
        )
        vim.notify(msg, vim.log.levels.ERROR)
    end)
    return
end

vim.loader.enable()

if vim.fn.has("0.12") == 1 then
    require("vim._extui").enable({})
end

_G.Util = require("util")
require("config.options")
require("config.keymaps")
require("config.misc")

if vim.env.XDG_SESSION_TYPE ~= "tty" then
    require("config.plugins")
end

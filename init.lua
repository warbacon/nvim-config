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
    vim.defer_fn(function()
        local v = vim.version()
        local msg = string.format(
            "This config requires Neovim v0.11.x or higher. You have v%d.%d.%d.",
            v.major,
            v.minor,
            v.patch
        )
        vim.notify(msg, vim.log.levels.WARN)
    end, 100)
    return
end

if vim.fn.has("nvim-0.12") == 1 then
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.deprecate = function() end

    require("vim._extui").enable({})
end

_G.Util = require("util")

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
require("config.extra")
require("config.lazy")

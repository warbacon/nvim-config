--
-- ███    ███ ██  ██████  ██    ██ ██ ███    ███
-- ████  ████ ██ ██    ██ ██    ██ ██ ████  ████
-- ██ ████ ██ ██ ██    ██ ██    ██ ██ ██ ████ ██
-- ██  ██  ██ ██ ██    ██  ██  ██  ██ ██  ██  ██
-- ██      ██ ██  ██████    ████   ██ ██      ██
--
-- Made by Warbacon
-- https://github.com/warbacon/nvim-config

vim.loader.enable()

if vim.fn.has("nvim-0.12") == 0 then
    local v = vim.fn.api_info().version
    if v then
        local msg = string.format(
            "This config requires Neovim v0.12.x or higher. You have v%d.%d.%d.",
            v.major,
            v.minor,
            v.patch
        )
        vim.schedule(function()
            vim.notify(msg, vim.log.levels.ERROR)
        end)
    end
    return
end

require("vim._core.ui2").enable({})
vim.lsp.on_type_formatting.enable()
vim.lsp.document_color.enable(true, nil, { style = "virtual" })

_G.Util = require("util")

require("config.options")
require("config.keymaps")
require("config.misc")

if vim.o.termguicolors then
    require("config.plugins")
end

--
-- ███    ███ ██  ██████  ██    ██ ██ ███    ███
-- ████  ████ ██ ██    ██ ██    ██ ██ ████  ████
-- ██ ████ ██ ██ ██    ██ ██    ██ ██ ██ ████ ██
-- ██  ██  ██ ██ ██    ██  ██  ██  ██ ██  ██  ██
-- ██      ██ ██  ██████    ████   ██ ██      ██
--
-- Made by Warbacon
-- https://github.com/warbacon/nvim-config

if vim.fn.has("nvim-0.12") == 0 then
    vim.defer_fn(function()
        local v = vim.version()
        local msg = string.format(
            "This config requires Neovim v0.12.x or higher. You have v%d.%d.%d.",
            v.major,
            v.minor,
            v.patch
        )
        vim.notify(msg, vim.log.levels.WARN)
    end, 100)
    return
end

if not vim.loader.enabled then
    vim.loader.enable()
end

require("options")
require("keymaps")
require("misc")

if vim.env.XDG_SESSION_TYPE ~= "tty" then
    -- require("vim._extui").enable({})
    require("plugins")
    require("lsp")
    require("treesitter")
end

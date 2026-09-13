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

require("options")
require("keymaps")
require("autocmds")

if vim.env.TERM ~= "linux" then
	require("plugins")
	require("statusline").setup()
end

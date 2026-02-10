local M = {}

M.init = function()
	if vim.g.colors_name then
		vim.cmd("hi clear")
	end

	vim.g.colors_name = "clearpine"

	local colors = require("clearpine.colors")
	for group, hl in pairs(colors) do
		vim.api.nvim_set_hl(0, group, hl)
	end

	local palette = require("clearpine.palette")

	vim.g.terminal_color_1 = palette.love
	vim.g.terminal_color_2 = palette.leaf
end

return M

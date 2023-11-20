return {
	-- CATPPUCCIN --------------------------------------------------------------
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		opts = {
			custom_highlights = function()
				return {
					CursorLine = { bg = "None" },
				}
			end,
			integrations = {
				mason = true,
			},
		},
		init = function()
			vim.cmd.colorscheme("catppuccin")
			vim.opt.cursorline = true
		end,
	},

	-- KANAGAWA ----------------------------------------------------------------
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		opts = {
			compile = true,
			undercurl = false,
			overrides = function()
				return {
					CursorLine = { bg = "None" },
				}
			end,
		},
		init = function()
			vim.cmd.colorscheme("kanagawa")
			vim.opt.cursorline = true
		end,
	},
}

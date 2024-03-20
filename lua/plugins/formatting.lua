return {
	-- CONFORM.LUA ------------------------------------------------------------
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>bf",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
				mode = "n",
			},
		},
		opts = {
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				fish = { "fish_indent" },
				lua = { "stylua" },
				python = { "ruff_format" },
				sh = { "shfmt" },
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"-style={IndentWidth: 4, BreakBeforeBraces: Linux, AccessModifierOffset: -4}",
					},
				},
				shfmt = { prepend_args = { "-i", "4", "-ci", "-bn" } },
			},
		},
	},
}

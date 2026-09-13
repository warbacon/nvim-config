---@type vim.lsp.Config
return {
	bundle_path = vim.fn.expand("$MASON/packages/powershell-editor-services"),
	settings = {
		powershell = {
			codeFormatting = {
				preset = "Stroustrup",
			},
		},
	},
}

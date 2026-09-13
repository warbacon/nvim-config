---@type vim.lsp.Config
return {
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
		},
	},
	before_init = function(_, config)
		if not config.settings then
			return
		end
		config.settings.yaml.schemas = vim.tbl_deep_extend(
			"force",
			config.settings.yaml.schemas --[[@as table]],
			require("schemastore").yaml.schemas()
		)
	end,
}

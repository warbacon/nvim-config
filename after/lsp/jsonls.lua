---@type vim.lsp.Config
return {
	settings = {
		json = {
			validate = { enable = true },
		},
	},
	before_init = function(_, config)
		if not config.settings then
			return
		end
		config.settings.json.schemas = config.settings.json.schemas or {}
		vim.list_extend(config.settings.json.schemas--[[@as table]], require("schemastore").json.schemas())
	end,
}

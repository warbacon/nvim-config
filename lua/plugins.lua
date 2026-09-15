require("packy").setup({
	-- CENDRE --------------------------------------------------------------------------------------
	{
		src = "https://github.com/Aejkatappaja/cendre",
		config = function()
			vim.cmd.colorscheme("cendre")
		end,
	},

	-- PINO.NVIM -----------------------------------------------------------------------------------
	{
		src = "https://github.com/warbacon/pino.nvim",
		cond = false,
		config = function()
			require("pino").setup({
				plugins = {
					lualine = false,
					mini = true,
					snacks = true,
				},
			})
			vim.cmd.colorscheme("pino")
		end,
	},

	-- MINI.NVIM -----------------------------------------------------------------------------------
	{
		src = "https://github.com/nvim-mini/mini.nvim",
		config = function()
			require("mini.icons").setup()
			require("mini.splitjoin").setup()
			require("mini.diff").setup({
				view = {
					style = "sign",
				},
			})
		end,
	},

	-- SNACKS.NVIM ---------------------------------------------------------------------------------
	{
		src = "https://github.com/folke/snacks.nvim",
		config = function()
			require("snacks").setup({
				picker = {
					enabled = true,
					layout = function()
						return {
							preview = vim.o.lines >= 25,
							layout = {
								width = 0.85,
								max_width = 180,
								min_width = 0,
								min_height = 0,
								backdrop = true,
							},
							preset = vim.o.columns >= 120 and "default" or "vertical",
						}
					end,
				},
			})
			vim.keymap.set("n", "<Leader><Leader>", function()
				Snacks.picker.files({ hidden = true })
			end, { desc = "Find files" })
			vim.keymap.set("n", "<Leader>,", Snacks.picker.buffers, { desc = "List buffers" })
			vim.keymap.set("n", "<Leader>sh", Snacks.picker.help, { desc = "Search help" })
			vim.keymap.set("n", "<Leader>sg", Snacks.picker.grep, { desc = "Search grep" })
			vim.keymap.set("n", "<Leader>sd", Snacks.picker.diagnostics, { desc = "Search diagnostics" })
		end,
	},

	-- TREE-SITTER ---------------------------------------------------------------------------------
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter").update()
		end,
		config = function()
			require("nvim-treesitter").install({
				"astro",
				"css",
				"diff",
				"git_config",
				"gitcommit",
				"html",
				"ini",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"svelte",
				"toml",
				"typescript",
				"xml",
				"yaml",
			})
		end,
	},
	{
		src = "https://github.com/tronikelis/ts-autotag.nvim",
		config = function()
			require("ts-autotag").setup({
				filetypes = {
					"astro",
					"html",
					"svelte",
					"typescriptreact",
					"xml",
				},
			})

			vim.keymap.set("n", "grn", function()
				if not require("ts-autotag").rename() then
					vim.lsp.buf.rename()
				end
			end)
		end,
	},

	-- LSP -----------------------------------------------------------------------------------------
	{ src = "https://github.com/b0o/SchemaStore.nvim" },
	{
		src = "https://github.com/j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		config = function()
			vim.lsp.enable({
				"astro",
				"bashls",
				"cssls",
				"emmylua_ls",
				"jsonls",
				"rust_analyzer",
				"svelte",
				"tsc",
				vim.fn.has("win32") == 1 and "powershell_es" or "",
			})
		end,
	},

	-- CONFORM.NVIM --------------------------------------------------------------------------------
	{
		src = "https://github.com/stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					fish = { "fish_indent" },
					lua = { "stylua" },
					["_"] = { "trim_whitespace", "trim_newlines", lsp_format = "prefer" },
				},
				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						vim.schedule(function()
							vim.notify("Format skipped on save", vim.log.levels.WARN)
						end)
						return
					end
					return { timeout_ms = 500 }
				end,
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					vim.b.disable_autoformat = true
					vim.schedule(function()
						vim.notify("Autoformat disabled (buffer)", vim.log.levels.INFO)
					end)
				else
					vim.g.disable_autoformat = true
					vim.schedule(function()
						vim.notify("Autoformat disabled (global)", vim.log.levels.INFO)
					end)
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
				vim.notify("Autoformat enabled", vim.log.levels.INFO)
			end, {
				desc = "Re-enable autoformat-on-save",
			})
		end,
	},

	-- MASON ---------------------------------------------------------------------------------------
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
	},
	{
		src = "https://github.com/mason-org/mason.nvim",
		config = function()
			require("mason").setup()
			vim.keymap.set("n", "<Leader>m", "<cmd>Mason<CR>", { silent = true, desc = "Open Mason" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "mason",
				once = true,
				callback = function()
					require("mason-lspconfig").setup({ automatic_enable = false })

					local mr = require("mason-registry")
					mr.refresh(function()
						local to_install = {
							shellcheck = true,
							shfmt = true,
							["rust-analyzer"] = false,
						}

						for server in pairs(vim.tbl_keys(vim.lsp._enabled_configs)) do
							local package_name = require("mason-lspconfig").get_mappings().lspconfig_to_package[server]
							if package_name and to_install[package_name] ~= false then
								to_install[package_name] = true
							end
						end

						for ft, formatters in pairs(require("conform").formatters_by_ft) do
							if ft ~= "_" then
								for _, formatter in pairs(formatters) do
									if type(formatter) == "string" and mr.has_package(formatter) then
										to_install[formatter] = true
									end
								end
							end
						end

						for package_name, value in pairs(to_install) do
							if value and not mr.is_installed(package_name) then
								mr.get_package(package_name):install()
							end
						end
					end)
				end,
			})
		end,
	},

	-- GUESS-INDENT.NVIM ---------------------------------------------------------------------------
	{
		src = "https://github.com/NMAC427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup()
		end,
	},

	-- BLINK.CMP -----------------------------------------------------------------------------------
	{
		src = "https://github.com/saghen/blink.cmp",
		preload = true,
		event = { "InsertEnter", "CmdlineEnter" },
		version = vim.version.range("*"),
		config = function()
			require("blink.cmp").setup()
		end,
	},

	-- OIL.NVIM ------------------------------------------------------------------------------------
	{
		src = "https://github.com/stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				lsp_file_methods = {
					autosave_changes = "unmodified",
				},
				watch_for_changes = true,
				keymaps = {
					["`"] = false,
					[","] = { "actions.cd", mode = "n" },
				},
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name)
						return name == ".git"
					end,
				},
			})
			vim.keymap.set("n", "-", "<cmd>Oil<CR>", { silent = true, desc = "Open Oil" })
		end,
	},

	-- QUICKER.NVIM --------------------------------------------------------------------------------
	{
		src = "https://github.com/stevearc/quicker.nvim",
		config = function()
			require("quicker").setup()
		end,
	},

	-- RENDER-MARKDOWN.NVIM ------------------------------------------------------------------------
	{ src = "https://github.com/meanderingprogrammer/render-markdown.nvim" },
})

-- UNDOTREE ----------------------------------------------------------------------------------------
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<Leader>u", "<cmd>Undotree<CR>", { silent = true, noremap = true, desc = "Toggle Undotree" })

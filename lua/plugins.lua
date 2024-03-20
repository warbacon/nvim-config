return {
	-- Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			styles = { booleans = { "bold" } },
			custom_highlights = function(colors)
				return {
					CursorLine = { bg = colors.none },
					CursorLineNr = { fg = colors.mauve },
				}
			end,
			integrations = {
				fidget = true,
				mason = true,
				native_lsp = {
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
			vim.opt.cursorline = true
		end,
	},

	-- Neogit
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit", "NeogitResetState" },
		keys = { { "<leader>gg", "<cmd>Neogit<cr>", mode = "n" } },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		opts = {},
	},

	-- Mini.comment
	{
		"echasnovski/mini.comment",
		keys = { { "gc", mode = { "n", "v" } } },
		opts = {},
	},

	-- Vim sleuth
	{
		"tpope/vim-sleuth",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},

	-- MarkdownPreview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- Gitsigns
	{
		"lewis6991/gitsigns.nvim",
		event = { "UIEnter" },
		keys = {
			{
				"<leader>gp",
				"<cmd>Gitsigns preview_hunk_inline<cr>",
				mode = "n",
				desc = "[G]it [P]review hunk",
			},
			{
				"<leader>gr",
				"<cmd>Gitsigns reset_hunk<cr>",
				mode = "n",
				desc = "[G]it [R]eset Hunk",
			},
		},
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		branch = "0.1.x",
		dependencies = {
			{ "stevearc/dressing.nvim", opts = {} },
			"natecraddock/telescope-zf-native.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("zf-native")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Shortcut for searching your neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	-- nvim-highlight-colors
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			render = "virtual",
			enable_named_colors = false,
		},
	},

	-- Kitty config highlighting
	{
		"fladson/vim-kitty",
		enabled = os.getenv("TERM") == "xterm-kitty",
		ft = "kitty",
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			-- Add hyprlang filetype
			vim.filetype.add({
				pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			})
			---@diagnostic disable: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"diff",
					"json",
					"jsonc",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"toml",
					"vim",
					"vimdoc",
					"yaml",
				},
				auto_install = true,
				ignore_install = { "ini", "rasi" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ap"] = "@parameter.outer",
							["ip"] = "@parameter.inner",
							["ac"] = "@conditional.outer",
							["ic"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
						},
					},
				},
			})
		end,
	},

	-- none-ls
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.fish,
					null_ls.builtins.diagnostics.markdownlint,
					null_ls.builtins.diagnostics.zsh,
				},
			})
		end,
	},

	-- Conform
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		keys = {
			{
				"<Leader>ff",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "[F]ormat [F]ile",
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

	-- Lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "folke/neodev.nvim", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				end,
			})

			-- Set lsp capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			local servers = {
				bashls = {},
				pyright = {},
				clangd = {},
				powershell_es = {
					settings = {
						powershell = { codeFormatting = { Preset = "OTBS" } },
					},
				},
				lua_ls = {
					settings = {
						Lua = { completion = { callSnippet = "Replace" }, },
					},
				},
			}

			if vim.fn.has("win32") == 1 then
				servers.bashls = nil
				servers.clangd = nil
			else
				servers.powershell_es = nil
			end

			-- Ensure the servers and tools above are installed
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"clang-format",
				"markdownlint",
				"ruff",
				"shellcheck",
				"shfmt",
				"stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- Completions
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			-- see `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					-- select the [n]ext item.
					["<c-n>"] = cmp.mapping.select_next_item(),
					-- select the [p]revious item.
					["<c-p>"] = cmp.mapping.select_prev_item(),
					-- manually trigger a completion from nvim-cmp.
					["<c-space>"] = cmp.mapping.complete({}),
					-- abort completion.
					["<C-e>"] = cmp.mapping.abort(),
					-- accept the completion.
					["<cr>"] = cmp.mapping.confirm({ select = true }),
					-- accept and replace.
					["<s-cr>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					-- abort complete and insert newline.
					["<c-cr>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<c-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<c-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}

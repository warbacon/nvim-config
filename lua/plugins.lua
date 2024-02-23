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
				telescope = { enabled = true },
				native_lsp = {
					enabled = true,
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

	-- Gitsigns
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		keys = {
			{ "<Leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>", mode = "n" },
			{ "<Leader>gr", "<cmd>Gitsigns reset_hunk<cr>", mode = "n" },
		},
		opts = {},
	},

	-- Markdown Preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n" },
			{ "gc", mode = "v" },
			{ "gbb", mode = "n" },
			{ "gb", mode = "v" },
		},
		opts = { mappings = { extra = false } },
	},

	-- Kitty syntax support
	{
		"fladson/vim-kitty",
		ft = "kitty",
		enabled = os.getenv("TERM") == "xterm-kitty",
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"fish",
				"go",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"svelte",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
        -- stylua: ignore
		keys = {
			{ "<Leader>ff", function() require("telescope.builtin").find_files() end, mode = "n" },
			{ "<Leader>fg", function() require("telescope.builtin").live_grep() end, mode = "n" },
			{ "<Leader>fh", function() require("telescope.builtin").help_tags() end, mode = "n" },
			{ "<Leader>fb", function() require("telescope.builtin").buffers() end, mode = "n" },
		},
	},

	-- Conform
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<Leader>bf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				python = { "isort", "black" },
			},
			formatters = {
				shfmt = { prepend_args = { "-i", "4", "-ci", "-bn" } },
				isort = { prepend_args = { "--profile", "black" } },
			},
		},
	},

	-- Rustaceanvim
	{
		"mrcjkb/rustaceanvim",
		enabled = vim.fn.executable("rust-analyzer") == 1,
		version = "^3",
		ft = { "rust" },
	},

	-- Mason
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"bash-language-server",
				"black",
				"clangd",
				"isort",
				"lua-language-server",
				"powershell-editor-services",
				"pyright",
				"shellcheck",
				"shfmt",
				"stylua",
				"svelte-language-server",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},

	-- Lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"mason.nvim",
		},
		opts = {},
		config = function()
			-- Setup mason-lspconfig.
			require("mason-lspconfig").setup()

			-- Setup language servers.
			local servers = {
				bashls = {},
				powershell_es = {},
				pyright = {},
				svelte = {},
				clangd = {
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							workleader = { checkThirdParty = "Disable" },
							diagnostics = { disable = { "missing-fields" } },
							completion = { callSnippet = "Replace" },
						},
					},
				},
			}

			if jit.os:find("Windows") then
				servers.clangd = nil
			end

			for server, opts in pairs(servers) do
				require("lspconfig")[server].setup(opts)
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<Leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				end,
			})
		end,
	},

	-- LuaSnip
	{
		"L3MON4D3/LuaSnip",
		build = not jit.os:find("Windows") and "make install_jsregexp",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		keys = {
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<tab>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<s-tab>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},

	-- Completions
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		opts = function()
			local cmp = require("cmp")
			return {
				window = {
					completion = {
						side_padding = 0,
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
						})(entry, vim_item)

						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "")

						return kind
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			}
		end,
	},
}

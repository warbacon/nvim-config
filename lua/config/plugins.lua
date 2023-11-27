return {
	-- KANAGAWA ----------------------------------------------------------------
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = true,
				overrides = function()
					return {
						CursorLine = { bg = "None" },
					}
				end,
			})
			vim.cmd("colorscheme kanagawa")
			vim.opt.cursorline = true
			vim.opt.colorcolumn = "80"
		end,
	},

	-- GITSIGNS ----------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
	},

	-- OIL.NVIM ----------------------------------------------------------------
	{
		"stevearc/oil.nvim",
		lazy = false,
		keys = {
			{ "-", "<CMD>Oil<CR>", mode = "n" },
		},
		config = function()
			local opts = {}
			if vim.fn.has("win32") == 0 then
				opts.delete_to_trash = true
			end
			require("oil").setup(opts)
		end,
	},

	-- MARKDOWN-PREVIEW --------------------------------------------------------
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- FTERM -------------------------------------------------------------------
	{
		"numToStr/fterm.nvim",
		keys = {
			{ "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>', mode = "n" },
			{ "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = "t" },
			{ "<A-g>", mode = "n" },
		},
		config = function()
			local fterm = require("FTerm")

			fterm.setup({
				cmd = os.getenv("SHELL") or "pwsh -NoLogo" or "powershell -NoLogo",
			})

			if vim.fn.executable("gitui") == 1 then
				local gitui = fterm:new({
					ft = "fterm_gitui",
					cmd = "gitui",
				})

				vim.keymap.set({ "n", "t" }, "<A-g>", function()
					gitui:toggle()
				end)
			end
		end,
	},

	-- COMMENTS ----------------------------------------------------------------
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n" },
			{ "gc", mode = "v" },
			{ "gb", mode = "v" },
		},
		opts = {},
	},

	-- CONFORM -----------------------------------------------------------------
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "n",
			},
		},
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
			},
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2", "-ci", "-bn" },
				},
			},
		},
	},

	-- TREESITTER --------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		config = function()
			require("nvim-treesitter.install").prefer_git = false
			require("nvim-treesitter.configs").setup({
				indent = { enable = true },
				highlight = { enable = true },
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"rust",
					"svelte",
					"vim",
					"vimdoc",
					"json",
					"yaml",
				},
			})
		end,
	},

	-- KITTY CONFIG HIGHLIGHTING -----------------------------------------------
	{
		"fladson/vim-kitty",
		ft = "kitty",
		enabled = os.getenv("TERM") == "xterm-kitty",
	},

	-- CLIPS -------------------------------------------------------------------
	{
		"Warbacon/vim-clips",
		ft = "clips",
		enabled = false,
	},

	-- WEBICONS ----------------------------------------------------------------
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	-- TELESCOPE ---------------------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
		},
		keys = {
			{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", mode = "n" },
			{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", mode = "n" },
			{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", mode = "n" },
		},
		config = function()
			require("telescope").load_extension("fzy_native")
		end,
	},

	-- MASON -------------------------------------------------------------------
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"bash-language-server",
				"ruff-lsp",
				"stylua",
				"shfmt",
				"pyright",
				"clangd",
				"shellcheck",
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

	-- LSPCONFIG ---------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		ft = { "sh", "rust", "lua", "python", "c", "cpp" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			-- Setup mason-lspconfig.
			require("mason-lspconfig").setup()

			-- Setup language servers.
			local lspconfig = require("lspconfig")

			if not jit.os:find("Windows") then
				lspconfig.bashls.setup({})
				lspconfig.clangd.setup({})
			end

			lspconfig.pyright.setup({})
			lspconfig.ruff_lsp.setup({
				init_options = {
					settings = {
						args = {
							"--ignore",
							"405",
						},
					},
				},
			})

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						workleader = {
							checkThirdParty = "Disable",
						},
						diagnostics = {
							disable = {
								"missing-fields",
							},
						},
					},
				},
			})

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

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
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>r", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3",
		enabled = vim.fn.executable("rust-analyzer") == 1,
		ft = { "rust" },
	},

	-- COMPLETIONS -------------------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
        -- stylua: ignore
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
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "…",
					}),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
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

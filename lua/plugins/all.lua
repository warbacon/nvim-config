return {
	-- GITSIGNS ----------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
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
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},

	-- CONFORM -----------------------------------------------------------------
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
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
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"diff",
					"go",
					"html",
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
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
                    "css",
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

	-- TELESCOPE ---------------------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = {
			"nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", mode = "n" },
			{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", mode = "n" },
			{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", mode = "n" },
		},
        config = function()
            require('telescope').load_extension('fzy_native')
        end
	},
}

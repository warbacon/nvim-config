-- Enable installed tree-sitter parsers
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)

		if not lang or not vim.treesitter.language.add(lang) then
			return
		end

		vim.treesitter.start()

		local ok = pcall(require, "nvim-treesitter")
		if ok and vim.treesitter.query.get(lang, "indents") then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

-- Highlight `yanked` zone
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		if vim.hl.hl_op then
			vim.hl.hl_op({ timeout = 100 })
		else
			vim.hl.on_yank({ timeout = 100 })
		end
	end,
})

-- Disable autocomment on `o`
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "o" })
	end,
})

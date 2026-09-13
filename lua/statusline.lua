local M = {}

local mode_disabled = false

---@type table<string,string>
local mode_map = {
	n = "normal",
	i = "insert",
	v = "visual",
	V = "visual",
	["\22"] = "visual",
	c = "command",
	R = "replace",
	t = "terminal",
	no = "operator",
	s = "select",
	S = "select",
	["\19"] = "select",
}

---@return string
local function mode()
	if mode_disabled then
		return ""
	end

	local current_mode = vim.api.nvim_get_mode().mode
	local lualine_mode = mode_map[current_mode] or "normal"
	local suffix = lualine_mode:sub(1, 1):upper() .. lualine_mode:sub(2)
	return "%#StatusLine" .. suffix .. "# %*"
end

---@param is_active boolean
---@param bufnr integer
---@param bufname string
---@return string
local function file_icon(is_active, bufnr, bufname)
	if not MiniIcons then
		return ""
	end

	local icon, hl = "", ""
	if vim.bo[bufnr].filetype == "help" then
		icon, hl = MiniIcons.get("filetype", "help")
	else
		icon, hl = MiniIcons.get("file", bufname)
	end

	if not is_active then
		return icon
	end

	return "%#" .. hl .. "#" .. icon .. "%*"
end

---@param bufnr integer
---@param bufname string
---@return string
local function buffer_name(bufnr, bufname)
	if bufname == "" then
		return "%f"
	end

	if vim.bo[bufnr].filetype == "help" then
		return vim.fn.fnamemodify(bufname, ":t")
	end

	return vim.fn.fnamemodify(bufname, ":~:.")
end

---@param bufnr integer
---@return string
local function buffer_modifiers(bufnr)
	if vim.bo[bufnr].modified then
		return ""
	end
	if vim.bo[bufnr].readonly then
		return "%#DiagnosticError#󰌾%*"
	end

	return ""
end

---@return string
M.render = function()
	local winid = vim.g.statusline_winid or 0
	local is_active = winid == vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local bufname = vim.api.nvim_buf_get_name(bufnr)

	local parts = {
		is_active and mode() or "",
		file_icon(is_active, bufnr, bufname),
		buffer_name(bufnr, bufname),
		buffer_modifiers(bufnr),
		"%=",
		is_active and vim.diagnostic.status(bufnr) or "",
		"%-11.(%l,%c%V%)",
	}

	return table.concat(
		vim.tbl_filter(function(v)
			return v ~= ""
		end, parts),
		" "
	)
end

M.setup = function()
	local function init_highlights()
		if not vim.g.colors_name then
			mode_disabled = true
			return
		end

		local ok, lualine_theme = pcall(require, "lualine.themes." .. vim.g.colors_name)

		if not ok then
			mode_disabled = true
			return
		else
			mode_disabled = false
		end

		for mode_name, colors in
			pairs(lualine_theme --[[@as table<unknown, unknown>]])
		do
			local a = colors.a
			if a then
				local suffix = mode_name:sub(1, 1):upper() .. mode_name:sub(2)
				vim.api.nvim_set_hl(0, "StatusLine" .. suffix, {
					fg = a.fg,
					bg = a.bg,
					bold = a.gui == "bold",
				})
			end
		end
	end

	init_highlights()
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = init_highlights,
	})

	vim.o.statusline = "%!v:lua.require'statusline'.render()"
end

return M

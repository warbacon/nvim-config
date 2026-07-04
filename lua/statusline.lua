local M = {}

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
    local current_mode = vim.api.nvim_get_mode().mode
    local lualine_mode = mode_map[current_mode] or "normal"
    local suffix = lualine_mode:sub(1, 1):upper() .. lualine_mode:sub(2)
    return "%#StatusLine" .. suffix .. "# %* "
end

---@param bufname string
---@param is_active boolean
---@return string
local function file_icon(bufname, bufnr, is_active)
    local icon_type = "file"
    if vim.bo[bufnr].filetype == "oil" then
        icon_type = "directory"
    end

    local icon, hl = MiniIcons.get(icon_type, bufname)
    if not icon then
        return ""
    end
    if not is_active or not hl then
        return icon .. " "
    end
    return "%#" .. hl .. "#" .. icon .. "%* "
end

---@return string
local function buffer_name(bufname)
    if bufname == "" then
        return "%f"
    end
    return vim.fn.fnamemodify(bufname, ":~:.")
end

---@return string
local function buffer_modifiers(bufnr)
    local bo = vim.bo[bufnr]
    local content = ""
    if bo.modified then
        content = content .. " [+]"
    end
    if bo.readonly then
        content = content .. " [-]"
    end
    return content
end

---@return string
function M.statusline()
    local winid = vim.g.statusline_winid or 0
    local is_active = winid == vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_win_get_buf(winid)
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    if vim.bo[bufnr].filetype == "oil" then
        bufname = bufname:sub(7)
    end

    return table.concat({
        is_active and mode() or "",
        file_icon(bufname, bufnr, is_active),
        buffer_name(bufname),
        buffer_modifiers(bufnr),
        "%=",
        is_active and vim.diagnostic.status(bufnr) or "",
        " %-11.(%l,%c%V%)",
    })
end

function M.setup()
    local function init_highlights()
        if not vim.g.colors_name then
            return
        end
        local ok, lualine_colors = pcall(require, "lualine.themes." .. vim.g.colors_name)
        if not ok then
            return
        end
        for mode_name, colors in pairs(lualine_colors) do
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
    vim.api.nvim_create_autocmd("ColorScheme", { callback = init_highlights })

    _G.Statusline = M
    vim.o.statusline = "%!v:lua.Statusline.statusline()"
end

return M

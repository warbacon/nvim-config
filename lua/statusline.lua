local M = {}

---@return integer
local statusline_bufnr = function()
    return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local file_icon = function()
    local bufname = vim.api.nvim_buf_get_name(statusline_bufnr())
    local icon = require("mini.icons").get("file", bufname)
    return icon and icon .. " " or ""
end

---@return string
local file_modifiers = function()
    local content = ""

    if vim.bo.modified then
        content = " [+]"
    end

    if vim.bo.readonly then
        content = content .. " [-]"
    end

    return content
end

---@return string
M.render = function()
    return table.concat({
        file_icon(),
        "%f",
        -- file_modifiers(),
        "%=",
        vim.diagnostic.status(statusline_bufnr()),
        " %l:%c",
    })
end

return M

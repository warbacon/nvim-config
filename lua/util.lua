local M = {}

M.is_win = vim.uv.os_uname().sysname:find("Windows") ~= nil
M.is_lin = vim.uv.os_uname().sysname:find("Linux") ~= nil

return M

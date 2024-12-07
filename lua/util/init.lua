local M = {}

M.icons = require("util.icons")
M.lsp = { servers = require("util.lsp.servers") }
M.is_win = vim.uv.os_uname().sysname:find("Windows") ~= nil

return M

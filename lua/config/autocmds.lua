-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd

-- Fix cursor at leave
autocmd("VimLeave", {
    callback = function()
        vim.opt.guicursor = ""
        vim.api.nvim_chan_send(vim.api.nvim_get_vvar("stderr"), "\x1b[ q")
    end,
})

-- Disable auto comment
autocmd("FileType", {
    callback = function()
        vim.opt.formatoptions:remove({ "o", "r" })
    end,
})

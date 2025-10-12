local M = {}

---@class Icons
---@field indent string
---@field signs string[]
---@field kinds table<string, string>

---@type Icons
M.icons = {
    indent = "▏",
    signs = { "", "", "", "" },
    kinds = {
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Keyword = "",
        Method = "",
        Module = "",
        Operator = "",
        Property = "",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "",
    },
}

M.treesitter = {}
M.treesitter._installed = nil ---@type table<string,string>?
function M.treesitter.get_installed()
    if not M.treesitter._installed then
        M.treesitter._installed = {}
        for _, lang in ipairs(require("nvim-treesitter").get_installed()) do
            M.treesitter._installed[lang] = lang
        end
    end

    return M.treesitter._installed
end

function M.bootstrap_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.uv.fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)

    vim.api.nvim_create_autocmd("FileType", {
        desc = "User: fix backdrop for lazy window",
        pattern = "lazy_backdrop",
        group = vim.api.nvim_create_augroup("lazynvim-fix", { clear = true }),
        callback = function(ctx)
            local win = vim.fn.win_findbuf(ctx.buf)[1]
            vim.api.nvim_win_set_config(win, { border = "none" })
        end,
    })

    vim.keymap.set("n", "<Leader>l", require("lazy").show)
end

return M

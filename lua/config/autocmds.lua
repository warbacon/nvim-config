local autocmd = vim.api.nvim_create_autocmd

-- Fix cursor at leave
autocmd("VimLeave", {
    callback = function()
        vim.opt.guicursor = ""
        vim.api.nvim_chan_send(vim.api.nvim_get_vvar("stderr"), "\x1b[ q")
    end,
})

-- Highlight when yanking text
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Disable auto comment
autocmd("FileType", {
    callback = function()
        vim.opt.formatoptions:remove({ "o", "r" })
    end,
})

-- Hide signcolumn in netrw
autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.opt_local.signcolumn = "no"
    end,
})

-- This autocmd will only trigger when a file was loaded from the cmdline.
-- It will render the file as quickly as possible.
autocmd("BufReadPost", {
    once = true,
    callback = function(event)
        -- Skip if we already entered vim
        if vim.v.vim_did_enter == 1 then
            return
        end

        -- Try to guess the filetype (may change later on during Neovim startup)
        local ft = vim.filetype.match({ buf = event.buf })
        if ft then
            -- Add treesitter highlights and fallback to syntax
            local lang = vim.treesitter.language.get_lang(ft)
            if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
                vim.bo[event.buf].syntax = ft
            end

            -- Trigger early redraw
            vim.cmd([[redraw]])
        end
    end,
})

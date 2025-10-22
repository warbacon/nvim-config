return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = function()
        require("nvim-treesitter").update()
    end,
    config = function()
        local ts_parsers = {
            "astro",
            "bash",
            "c",
            "cpp",
            "css",
            "fish",
            "gitcommit",
            "go",
            "html",
            "hyprlang",
            "ini",
            "java",
            "javascript",
            "json",
            "jsonc",
            "kitty",
            "lua",
            "markdown",
            "markdown_inline",
            "nix",
            "printf",
            "python",
            "regex",
            "svelte",
            "toml",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        }

        if vim.fn.has("win32") == 0 then
            require("nvim-treesitter").install(ts_parsers):wait(100000)
        end

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(ev.match)

                if Util.treesitter.get_installed()[lang] then
                    vim.treesitter.start()
                    if lang and vim.treesitter.query.get(lang, "indents") then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end
            end,
        })
    end,
}

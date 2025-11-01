return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = vim.fn.argc(-1) == 0,
    event = "VeryLazy",
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

        local installed_parsers = require("nvim-treesitter").get_installed()

        if vim.fn.has("win32") == 0 then
            local to_install = vim.tbl_filter(function(lang)
                return not installed_parsers[lang]
            end, ts_parsers)

            if #to_install > 0 then
                require("nvim-treesitter.install").install(to_install)
            end
        end

        local filetypes = {}
        for _, lang in ipairs(installed_parsers) do
            for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
                table.insert(filetypes, ft)
            end
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(ev.match)

                vim.treesitter.start()
                if lang and vim.treesitter.query.get(lang, "indents") then
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}

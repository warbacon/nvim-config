return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "astro",
                "bash",
                "c",
                "cmake",
                "cpp",
                "css",
                "dockerfile",
                "fish",
                "git_config",
                "gitcommit",
                "html",
                "hyprlang",
                "ini",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "nix",
                "printf",
                "python",
                "rasi",
                "regex",
                "svelte",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter").install(opts.ensure_installed)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
                desc = "Enable treesitter highlighting and indent when supported",
                callback = function()
                    if pcall(vim.treesitter.start) then
                        if vim.treesitter.query.get(vim.treesitter.get_parser():lang(), "indents") then
                            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        end
                    end
                end,
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "LazyFile",
        opts = {
            opts = {
                enable_close = false,
            },
        },
    },
}

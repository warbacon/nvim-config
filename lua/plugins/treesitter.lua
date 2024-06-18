return {
    -- NVIM-TREESITTER =========================================================
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "LazyFile", "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        build = ":TSUpdate",
        init = function()
            vim.filetype.add({
                extension = { rasi = "rasi" },
                pattern = {
                    [".*/mako/config"] = "dosini",
                    [".*/hypr/.+%.conf"] = "hyprlang",
                    ["%.env%.[%w_.-]+"] = "sh",
                },
            })
        end,
        main = "nvim-treesitter.configs",
        opts = function()
            local opts = {
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "html",
                    "json",
                    "jsonc",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "toml",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                highlight = { enable = true },
                indent = { enable = true },
            }

            local function have(path)
                return vim.uv.fs_stat(vim.env.HOME .. "/.config/" .. path) ~= nil
            end

            local function add(parser)
                table.insert(opts.ensure_installed, parser)
            end

            if have("fish") then
                add("fish")
            end

            if have("hypr") then
                add("hyprlang")
            end

            if have("rofi") then
                add("rasi")
            end

            return opts
        end,
    },
}

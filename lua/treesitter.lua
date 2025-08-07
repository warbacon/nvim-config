local ts_parsers = {
    "astro",
    "bash",
    "c",
    "cpp",
    "css",
    "dockerfile",
    "fish",
    "gitcommit",
    "html",
    "hyprlang",
    "ini",
    "javascript",
    "json",
    "jsonc",
    "lua",
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
}

require("nvim-treesitter").install(ts_parsers):wait(300000)

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.kind == "update" and ev.data.spec.name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if pcall(vim.treesitter.start) then
            if vim.treesitter.query.get(vim.treesitter.get_parser():lang(), "indents") then
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end
    end,
})

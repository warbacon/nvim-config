return {
    "b0o/incline.nvim",
    event = "LazyFile",
    opts = {
        hide = {
            only_win = true,
        },
        highlight = {
            groups = {
                InclineNormal = {
                    default = true,
                    group = "CursorLine",
                },
                InclineNormalNC = {
                    default = true,
                    group = "CursorLine",
                },
            },
        },
        render = function(props)
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
            if filename == "" then
                filename = "[Sin nombre]"
            end
            local icon, hl = MiniIcons.get("file", filename)
            local hl_color = string.format("#%06x", vim.api.nvim_get_hl(0, { name = hl }).fg)
            return {
                { icon, guifg = hl_color },
                { " " },
                { filename },
            }
        end,
    },
}

local M = {}

---@param colors? table<string,string>
M.setup = function(colors)
    local opts = require("pino.config").options

    if not colors then
        colors = require("pino.colors").setup()
    end

    ---@type table<string, vim.api.keyset.highlight>
    local highlights = {
        -- UI
        ColorColumn = { bg = colors.overlay },
        CurSearch = { fg = colors.base, bg = colors.mango },
        CursorColumn = { link = "CursorLine" },
        CursorLine = { bg = colors.surface },
        FloatBorder = { fg = colors.pine, bg = colors.surface },
        FloatTitle = { fg = colors.pine, bg = colors.surface, bold = opts.style.bold },
        LineNr = { fg = colors.muted },
        MatchParen = { bg = colors.overlay },
        NonText = { fg = colors.muted },
        Normal = { fg = colors.text, bg = colors.base },
        NormalFloat = { bg = colors.surface },
        Pmenu = { bg = colors.surface },
        PmenuBorder = { link = "FloatBorder" },
        PmenuExtra = { fg = colors.subtle, italic = opts.style.italic },
        PmenuKind = { fg = colors.subtle },
        PmenuSbar = { bg = colors.overlay },
        PmenuSel = { bg = colors.overlay },
        PmenuThumb = { bg = colors.muted },
        Question = { fg = colors.foam },
        QuickFixLine = { fg = colors.mango },
        StatusLine = { fg = colors.subtle, bg = colors.surface },
        StatusLineNC = { fg = colors.muted, bg = colors.surface },
        Visual = { bg = colors.overlay },
        WinSeparator = { fg = colors.highlight },

        -- Syntax
        Comment = { fg = colors.muted, italic = opts.style.italic },
        Constant = { fg = colors.mango },
        Delimiter = { fg = colors.subtle },
        Directory = { fg = colors.pine },
        Function = { fg = colors.pine },
        Identifier = { fg = colors.foam },
        Operator = { fg = colors.subtle },
        PreProc = { italic = opts.style.italic },
        Quote = { fg = colors.subtle },
        Special = { fg = colors.iris },
        Statement = { fg = colors.rose, italic = opts.style.italic },
        String = { fg = colors.gold },
        Title = { fg = colors.pine, bold = opts.style.bold },
        Type = { fg = colors.text, bold = opts.style.bold },

        -- Messages
        ErrorMsg = { fg = colors.love },
        ModeMsg = { fg = colors.mango, bold = opts.style.bold },
        MoreMsg = { fg = colors.pine },
        OkMsg = { fg = colors.leaf },
        WarningMsg = { fg = colors.gold },

        -- Diagnostics
        DiagnosticError = { fg = colors.love },
        DiagnosticHint = { fg = colors.pine },
        DiagnosticInfo = { fg = colors.foam },
        DiagnosticWarn = { fg = colors.gold },
        DiagnosticFloatingError = { fg = colors.love, bg = colors.surface },
        DiagnosticFloatingHint = { fg = colors.pine, bg = colors.surface },
        DiagnosticFloatingInfo = { fg = colors.foam, bg = colors.surface },
        DiagnosticFloatingWarn = { fg = colors.gold, bg = colors.surface },
        DiagnosticUnderlineError = {
            sp = colors.love,
            undercurl = opts.style.undercurl,
            underline = not opts.style.undercurl,
        },
        DiagnosticUnderlineHint = {
            sp = colors.pine,
            undercurl = opts.style.undercurl,
            underline = not opts.style.undercurl,
        },
        DiagnosticUnderlineInfo = {
            sp = colors.foam,
            undercurl = opts.style.undercurl,
            underline = not opts.style.undercurl,
        },
        DiagnosticUnderlineWarn = {
            sp = colors.gold,
            undercurl = opts.style.undercurl,
            underline = not opts.style.undercurl,
        },

        -- Diff
        Added = { fg = colors.leaf },
        Changed = { fg = colors.foam },
        Removed = { fg = colors.love },
        DiffAdd = { fg = colors.base, bg = colors.leaf },
        DiffChange = { bg = colors.overlay },
        DiffDelete = { fg = colors.love, bold = opts.style.bold },
        DiffText = { fg = colors.base, bg = colors.foam },

        -- Treesitter
        ["@function.builtin"] = { fg = colors.pine, italic = opts.style.italic },
        ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
        ["@lsp.type.variable"] = { fg = "none" },
        ["@markup.heading.1.markdown"] = { fg = colors.pine, bold = opts.style.bold },
        ["@markup.heading.2.markdown"] = { fg = colors.gold, bold = opts.style.bold },
        ["@markup.heading.3.markdown"] = { fg = colors.leaf, bold = opts.style.bold },
        ["@markup.heading.4.markdown"] = { fg = colors.foam, bold = opts.style.bold },
        ["@markup.heading.5.markdown"] = { fg = colors.iris, bold = opts.style.bold },
        ["@markup.heading.6.markdown"] = { fg = colors.rose, bold = opts.style.bold },
        ["@markup.link"] = { underline = false },
        ["@markup.link.label"] = { fg = colors.foam },
        ["@markup.link.url"] = { fg = colors.iris, underline = true },
        ["@markup.quote.markdown"] = { fg = colors.subtle },
        ["@markup.raw"] = { bg = colors.overlay },
        ["@markup.raw.block"] = { bg = "none" },
        ["@module.builtin"] = { fg = colors.love },
        ["@punctuation"] = { link = "Delimiter" },
        ["@punctuation.special"] = { link = "Delimiter" },
        ["@tag"] = { fg = colors.love, bold = opts.style.bold },
        ["@tag.attribute"] = { fg = colors.foam },
        ["@tag.delimiter"] = { link = "Delimiter" },
        ["@variable"] = { fg = colors.text },
        ["@variable.builtin"] = { fg = colors.love, bold = opts.style.bold },
        ["@variable.member"] = { fg = colors.foam },

        -- LSP
        ["@lsp.typemod.variable.readonly"] = { link = "Constant" },
    }

    local enabled_plugins = opts.plugins or {}
    for plugin_name, enabled in pairs(enabled_plugins) do
        if enabled then
            local ok, plugin_highlights = pcall(function()
                return require("pino.groups." .. plugin_name).get(colors, opts)
            end)
            if ok then
                highlights = vim.tbl_extend("force", highlights, plugin_highlights)
            end
        end
    end

    opts.on_highlights(highlights, colors)

    return highlights
end

return M

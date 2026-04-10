# AGENTS.md

This repository contains **Miovim**, a personal **Neovim 0.12.x+** setup.

## Project overview

- Entry point: `init.lua`
- Core config modules:
  - `lua/config/options.lua`
  - `lua/config/keymaps.lua`
  - `lua/config/misc.lua`
  - `lua/config/plugins.lua`
- Plugin manager layer: `lua/packy.lua` (custom wrapper around `vim.pack`)
- LSP and filetype overrides: `after/lsp/*.lua` and `after/ftplugin/*.lua`
- Legacy colorscheme: `colors/oldpino.lua`

## Important architecture notes

1. **Plugin management is intentionally custom**: this config uses `packy`, not
   lazy.nvim or packer.nvim. Located at `lua/packy.lua`.
2. `packy` supports lightweight lazy loading through:
   - `event`: fires on Neovim events (`"BufRead"`, `"InsertEnter"`, etc.). Special:
     - `"VeryLazy"`: triggers on `UIEnter` with `vim.schedule_wrap()` to avoid
       UI blocking
   - `ft`: triggers on filetype detection
   - `preload`: optional, loads plugin immediately with `packadd` (without lazy
     loading)
   - `build`: optional, executes function on `PackChanged` event (e.g., for
     compile steps)
3. Plugin declarations and most plugin behavior live in
   `lua/config/plugins.lua`.
4. Primary theme is [`pino.nvim`](https://github.com/warbacon/pino.nvim)
   (rose-pine inspired).

## PackySpec Format

Each plugin spec in `lua/config/plugins.lua` is a table with the following keys:

```lua
{
    src = "https://github.com/user/plugin.nvim",  -- Required: GitHub repo URL
    name = "plugin",                               -- Optional: defaults to repo name
    version = "1.0.0",                             -- Optional: git tag/branch
    enable = true,                                 -- Optional: disable plugin (default: true)
    preload = false,                               -- Optional: load immediately
    event = "VeryLazy",                            -- Optional: event or array of events
    ft = "lua",                                    -- Optional: filetype or array of filetypes
    config = function() end,                       -- Optional: setup callback
    build = function() end,                        -- Optional: build callback on PackChanged
}
```

### Lazy Loading Patterns

- **No lazy loading** (loads immediately): no `event` or `ft` specified
- **Event-based**: `event = "BufRead"` or `event = { "BufRead", "BufNew" }`
  - Common events: `BufRead`, `BufNew`, `InsertEnter`, `CmdlineEnter`
- **VeryLazy** (non-blocking): `event = "VeryLazy"`
  - Loads after UI is fully ready using `UIEnter` + `vim.schedule_wrap()`
  - Best for non-essential plugins (completions, decorations, etc.)
- **Filetype-based**: `ft = "lua"` or `ft = { "lua", "json" }`
  - Loads on filetype detection
- **Build hooks**: `build = function() require("module").install() end`
  - Executes after `PackChanged` event (useful for post-install setup)

### Keybinds Provided by Packy

- `<Leader>pu`: Update all plugins (via `vim.pack.update()`)
- `<Leader>pr`: Restore plugins from lockfile
- `<Leader>pc`: Delete inactive plugins

### Validation and Error Handling

Packy validates all specs during setup and reports errors via `vim.notify()`.
Common errors:

- Missing `src` field
- Invalid `event`/`ft` type (must be string or string array)
- `config` must be a function
- `build` must be a function

## Editing guidelines for agents

1. Keep changes **small and targeted**; avoid broad refactors unless explicitly
   requested.
2. Follow existing Lua style:
   - 4-space indentation (`.stylua.toml`)
   - clear, direct naming
   - minimal comments unless needed for non-obvious logic
3. Preserve startup flow in `init.lua` and avoid changing load order without a
   concrete reason.
4. When changing plugins, keep consistency with existing `packy` patterns:
   - Declarative specs with clear intent
   - Scoped `config` callbacks
   - Lazy triggers (`event`, `ft`) to avoid startup bloat
   - Use `VeryLazy` for non-critical UI plugins
   - Use standalone mini.\* repos instead of monolithic `mini.nvim`
5. Prefer extending existing config files over introducing new abstraction
   layers.
6. Always validate plugin specs—packy will notify of errors at startup.

## Compatibility and assumptions

- Neovim versions earlier than **0.12** are unsupported.
- This config targets practical day-to-day coding with a no-nonsense approach.
- Plugins are installed via `vim.pack` and managed manually or via git
  submodules (lockfile-based updates via `vim.pack.update()`).

local M = {}

local default_data = {
    enable = true,
    preload = false,
    event = {},
    ft = {},
}

---@class PackySpec
---@field src string
---@field dir? string
---@field name? string
---@field version? string|vim.Version
---@field event? vim.api.keyset.events|vim.api.keyset.events[]|"VeryLazy"
---@field build? function
---@field enable? boolean
---@field preload? boolean
---@field ft? string|string[]
---@field config? function

local function load(plug)
    local data = plug.spec.data
    local packadded = false
    local configured = false
    local plugin_name = plug.spec.name

    local augroup = vim.api.nvim_create_augroup("packy_" .. plugin_name, { clear = true })

    local function ensure_packadd()
        if packadded then
            return
        end
        packadded = true

        if data.dir then
            local rtp = vim.opt.rtp:get()
            if not vim.tbl_contains(rtp, data.dir) then
                vim.opt.rtp:prepend(data.dir)
            end
            return
        end

        vim.cmd.packadd(plugin_name)
    end

    local function load_once()
        if configured then
            return
        end
        configured = true
        ensure_packadd()

        if data.config then
            data.config()
        end
    end

    if not data.enable then
        return
    end

    if data.preload then
        ensure_packadd()
    end

    if data.build then
        vim.api.nvim_create_autocmd("PackChanged", {
            group = augroup,
            callback = function(ev)
                if ev.data.spec.name == plugin_name then
                    data.build()
                end
            end,
        })
    end

    local is_very_lazy = vim.tbl_contains(data.event, "VeryLazy")
    if is_very_lazy then
        data.event = vim.tbl_filter(function(e)
            return e ~= "VeryLazy"
        end, data.event)
    end

    local has_event = not vim.tbl_isempty(data.event)
    local has_ft = not vim.tbl_isempty(data.ft)

    if is_very_lazy then
        vim.api.nvim_create_autocmd("UIEnter", {
            group = augroup,
            callback = vim.schedule_wrap(load_once),
            once = true,
        })
    end

    if has_event then
        vim.api.nvim_create_autocmd(data.event, {
            group = augroup,
            callback = load_once,
            once = true,
        })
    end

    if has_ft then
        vim.api.nvim_create_autocmd("FileType", {
            group = augroup,
            pattern = data.ft,
            callback = load_once,
            once = true,
        })
    end

    if not has_event and not has_ft and not is_very_lazy then
        load_once()
    end
end

local function setup_keybinds()
    vim.keymap.set("n", "<Leader>pu", vim.pack.update, { desc = "Update plugins" })
    vim.keymap.set("n", "<Leader>pr", function()
        vim.pack.update(nil, { target = "lockfile" })
    end, { desc = "Restore plugins from lockfile" })
    vim.keymap.set("n", "<Leader>pc", function()
        vim.pack.del(vim.iter(vim.pack.get())
            :filter(function(x)
                return not x.active
            end)
            :map(function(x)
                return x.spec.name
            end)
            :totable())
    end, { desc = "Delete non-active plugins" })
end

local function validate_spec(plugin, index)
    if type(plugin) ~= "table" then
        return false, string.format("Plugin #%d: must be a table, got %s", index, type(plugin))
    end

    if not plugin.src or type(plugin.src) ~= "string" then
        return false, string.format("Plugin #%d: missing or invalid 'src' (must be string)", index)
    end

    if plugin.enable ~= nil and type(plugin.enable) ~= "boolean" then
        return false, string.format("Plugin #%d (%s): 'enable' must be boolean", index, plugin.src)
    end

    if plugin.dir ~= nil and type(plugin.dir) ~= "string" then
        return false, string.format("Plugin #%d (%s): 'dir' must be string", index, plugin.src)
    end

    if plugin.preload ~= nil and type(plugin.preload) ~= "boolean" then
        return false, string.format("Plugin #%d (%s): 'preload' must be boolean", index, plugin.src)
    end

    if plugin.event ~= nil then
        if type(plugin.event) ~= "string" and type(plugin.event) ~= "table" then
            return false, string.format("Plugin #%d (%s): 'event' must be string or string[]", index, plugin.src)
        end
        if type(plugin.event) == "table" then
            for i, ev in ipairs(plugin.event) do
                if type(ev) ~= "string" then
                    return false,
                        string.format(
                            "Plugin #%d (%s): 'event[%d]' must be string, got %s",
                            index,
                            plugin.src,
                            i,
                            type(ev)
                        )
                end
            end
        end
    end

    if plugin.ft ~= nil then
        if type(plugin.ft) ~= "string" and type(plugin.ft) ~= "table" then
            return false, string.format("Plugin #%d (%s): 'ft' must be string or string[]", index, plugin.src)
        end
        if type(plugin.ft) == "table" then
            for i, filetype in ipairs(plugin.ft) do
                if type(filetype) ~= "string" then
                    return false,
                        string.format(
                            "Plugin #%d (%s): 'ft[%d]' must be string, got %s",
                            index,
                            plugin.src,
                            i,
                            type(filetype)
                        )
                end
            end
        end
    end

    if plugin.config ~= nil and type(plugin.config) ~= "function" then
        return false, string.format("Plugin #%d (%s): 'config' must be function", index, plugin.src)
    end

    if plugin.build ~= nil and type(plugin.build) ~= "function" then
        return false, string.format("Plugin #%d (%s): 'build' must be function", index, plugin.src)
    end

    return true
end

local function normalize_spec(plugin)
    if plugin.event and type(plugin.event) == "string" then
        plugin.event = { plugin.event }
    end
    if plugin.ft and type(plugin.ft) == "string" then
        plugin.ft = { plugin.ft }
    end
    return plugin
end

local function resolve_dir_path(plugin)
    if type(plugin.dir) ~= "string" or plugin.dir == "" then
        return nil
    end

    local dir_path = vim.fn.fnamemodify(vim.fs.normalize(vim.fn.expand(plugin.dir)), ":p")
    local stat = vim.uv.fs_stat(dir_path)

    if stat and stat.type == "directory" then
        return dir_path
    end

    return nil
end

---@param spec PackySpec[]
function M.setup(spec)
    if type(spec) ~= "table" then
        vim.schedule(function()
            vim.notify("packy is not receiving a table", vim.log.levels.ERROR)
        end)
        return
    end

    setup_keybinds()

    M.resolved_spec = {}

    for idx, plugin in ipairs(spec) do
        local valid, err = validate_spec(plugin, idx)
        if not valid then
            vim.schedule(function()
                if err then
                    vim.notify(err, vim.log.levels.ERROR)
                end
            end)
            goto continue
        end

        plugin = normalize_spec(plugin)
        local dir_path = resolve_dir_path(plugin)
        local data = vim.tbl_deep_extend("force", {}, default_data, {
            enable = plugin.enable,
            preload = plugin.preload,
            event = plugin.event or {},
            ft = plugin.ft or {},
            config = plugin.config,
            build = plugin.build,
        })

        if dir_path then
            data.dir = dir_path
        end

        table.insert(M.resolved_spec, {
            src = plugin.src,
            version = plugin.version,
            name = plugin.name,
            data = data,
        })

        ::continue::
    end

    if not vim.tbl_isempty(M.resolved_spec) then
        vim.pack.add(M.resolved_spec, { load = load })
    end
end

return M

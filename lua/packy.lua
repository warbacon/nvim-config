local M = {}

---@class PackySpec
---@field src string
---@field path? string
---@field name? string
---@field version? string|vim.Version
---@field event? vim.api.keyset.events|vim.api.keyset.events[]|"VeryLazy"
---@field build? function
---@field enabled? boolean
---@field preload? boolean
---@field ft? string|string[]
---@field config? function

local function load(plug)
    local data = plug.spec.data
    local loaded = false
    local configured = false
    local plugin_name = plug.spec.name
    local augroup = vim.api.nvim_create_augroup("packy_" .. plugin_name, { clear = true })

    local function activate_plugin()
        if loaded then
            return
        end
        loaded = true

        if data.path then
            local rtp = vim.opt.rtp:get()
            if not vim.tbl_contains(rtp, data.path) then
                vim.opt.rtp:prepend(data.path)
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
        activate_plugin()

        if data.config then
            data.config()
        end
    end

    if not data.enabled then
        return
    end

    if data.preload then
        activate_plugin()
    end

    if data.build then
        vim.api.nvim_create_autocmd("PackChanged", {
            group = augroup,
            callback = function(ev)
                if ev.data and ev.data.spec and ev.data.spec.name == plugin_name then
                    data.build()
                end
            end,
        })
    end

    local is_very_lazy = false
    local events = {}
    for _, event in ipairs(data.event) do
        if event == "VeryLazy" then
            is_very_lazy = true
        else
            table.insert(events, event)
        end
    end

    local has_event = #events > 0
    local has_ft = #data.ft > 0

    if is_very_lazy then
        vim.api.nvim_create_autocmd("UIEnter", {
            group = augroup,
            callback = vim.schedule_wrap(load_once),
            once = true,
        })
    end

    if has_event then
        vim.api.nvim_create_autocmd(events, {
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

local function notify_error(message)
    vim.schedule(function()
        vim.notify(message, vim.log.levels.ERROR)
    end)
end

local function to_list(value)
    if type(value) == "string" then
        return { value }
    end

    if type(value) == "table" then
        return value
    end

    return {}
end

local function resolve_path(path)
    if type(path) ~= "string" or path == "" then
        return nil
    end

    local expanded = vim.fn.expand(path)
    local absolute = vim.uv.fs_realpath(expanded) or vim.fn.fnamemodify(expanded, ":p")
    local normalized = vim.fs.normalize(absolute):gsub("[/\\]+$", "")
    local stat = vim.uv.fs_stat(normalized)

    if stat and stat.type == "directory" then
        return normalized
    end

    return nil
end

local function normalize_spec(plugin)
    local enabled = plugin.enabled
    if enabled == nil then
        enabled = true
    end

    local preload = plugin.preload
    if preload == nil then
        preload = false
    end

    return {
        src = plugin.src,
        version = plugin.version,
        name = plugin.name,
        data = {
            enabled = enabled,
            preload = preload,
            event = to_list(plugin.event),
            ft = to_list(plugin.ft),
            config = plugin.config,
            build = plugin.build,
            path = resolve_path(plugin.path),
        },
    }
end

---@param spec PackySpec[]
function M.setup(spec)
    if type(spec) ~= "table" or not vim.islist(spec) then
        notify_error("packy.setup expects a list of PackySpec")
        return
    end

    setup_keybinds()

    M.resolved_spec = {}

    for _, plugin in ipairs(spec) do
        if type(plugin) ~= "table" or type(plugin.src) ~= "string" then
            notify_error("Invalid packy plugin spec: expected table with 'src'")
            return
        end

        if plugin.config ~= nil and type(plugin.config) ~= "function" then
            notify_error("Invalid packy plugin spec: 'config' must be a function")
            return
        end

        if plugin.build ~= nil and type(plugin.build) ~= "function" then
            notify_error("Invalid packy plugin spec: 'build' must be a function")
            return
        end

        table.insert(M.resolved_spec, normalize_spec(plugin))
    end

    if #M.resolved_spec > 0 then
        vim.pack.add(M.resolved_spec, { load = load })
    end
end

return M

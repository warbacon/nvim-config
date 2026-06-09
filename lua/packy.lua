local M = {}

---@class PackySpec : vim.pack.Spec
---@field config? function
---@field dir? string
---@field enabled? boolean
---@field event? vim.api.keyset.events|vim.api.keyset.events[]

---@class PackyResolvedSpec : vim.pack.Spec
---@field data { config: function, dir: string, enabled: boolean, event: vim.api.keyset.events|vim.api.keyset.events[] }

local default_data = {
    config = nil,
    dir = nil,
    enabled = true,
    event = nil,
}

---@param spec PackySpec[]
---@return table|nil
local resolve_spec = function(spec)
    local resolved_spec = {}

    for _, plugin in ipairs(spec) do
        table.insert(resolved_spec, {
            src = plugin.src,
            name = plugin.name,
            version = plugin.version,
            data = vim.tbl_extend("force", default_data, {
                config = plugin.config,
                dir = plugin.dir,
                enabled = plugin.enabled,
                event = plugin.event,
            }),
        })
    end

    if vim.tbl_isempty(resolved_spec) then
        return nil
    end

    return resolved_spec
end

---@param plug { spec: PackyResolvedSpec, path: string }
local load = function(plug)
    if not plug.spec.data.enabled then
        return
    end

    if plug.spec.data.dir and vim.uv.fs_stat(plug.spec.data.dir) then
        vim.opt.rtp:append(plug.spec.data.dir)
    else
        vim.cmd.packadd(plug.spec.name)
    end

    if plug.spec.data.config then
        if plug.spec.data.event then
            vim.api.nvim_create_autocmd(plug.spec.data.event, {
                callback = plug.spec.data.config,
            })
        else
            plug.spec.data.config()
        end
    end
end

local function setup_keybinds()
    vim.keymap.set("n", "<Leader>pu", vim.pack.update, { desc = "Update plugins" })
    vim.keymap.set("n", "<Leader>pr", function()
        vim.pack.update(nil, { target = "lockfile" })
    end, { desc = "Restore plugins from lockfile" })
    vim.keymap.set("n", "<Leader>pc", function()
        ---@diagnostic disable-next-line: redundant-parameter
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

---@param spec PackySpec[]
M.setup = function(spec)
    if not spec then
        return
    end

    setup_keybinds()

    M.resolved_spec = resolve_spec(spec)

    if M.resolved_spec then
        vim.pack.add(M.resolved_spec, { load = load })
    end
end

return M

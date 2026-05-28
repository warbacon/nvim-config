local M = {}

---@class PackySpec : vim.pack.Spec
---@field config? function
---@field dev_dir? string
---@field enabled? boolean

---@class PackyResolvedSpec : vim.pack.Spec
---@field data { config: function, dev_dir: string, enabled: boolean }

local default_data = {
    config = nil,
    dev_dir = nil,
    enabled = true,
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
                dev_dir = plugin.dev_dir,
                enabled = plugin.enabled,
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

    if plug.spec.data.dev_dir and vim.uv.fs_stat(plug.spec.data.dev_dir) then
        vim.opt.rtp:append(plug.spec.data.dev_dir)
    else
        vim.cmd.packadd(plug.spec.name)
    end

    if plug.spec.data.config then
        plug.spec.data.config()
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

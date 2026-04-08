local M = {}

local default_data = {
    enable = true,
    event = {},
    ft = {},
}

---@class PackySpec
---@field src string
---@field name? string
---@field version? vim.Version
---@field event? string[]
---@field build? function
---@field enable? boolean
---@field ft? string[]
---@field config? function

local function load(plug)
    local data = plug.spec.data

    if not data.enable then
        return
    end

    vim.cmd.packadd(plug.spec.name)

    if not data.config then
        return
    end

    if not vim.tbl_isempty(data.ft) then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = data.ft,
            callback = data.config,
            once = true,
        })
        return
    end

    data.config()
end

---@param spec PackySpec[]
function M.setup(spec)
    if type(spec) ~= "table" then
        vim.schedule(function()
            vim.notify("packy is not receiving a table", vim.log.levels.ERROR)
        end)
        return
    end

    M.resolved_spec = {}

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

    M.resolved_spec = {}
    for _, plugin in ipairs(spec) do
        table.insert(M.resolved_spec, {
            src = plugin.src,
            version = plugin.version,
            name = plugin.name,
            data = vim.tbl_deep_extend("force", {}, default_data, {
                enable = plugin.enable,
                event = plugin.event,
                ft = plugin.ft,
                config = plugin.config,
            }),
        })
    end

    vim.pack.add(M.resolved_spec, { load = load })
end

return M

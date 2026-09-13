local M = {}

---@class PackySpec : vim.pack.Spec
---@field config? function
---@field dir? string
---@field cond? boolean
---@field event? vim.api.keyset.events|vim.api.keyset.events[]
---@field preload? boolean
---@field build? function

---@class PackyResolvedSpec : vim.pack.Spec
---@field data { config: function, dir: string, cond: boolean, event: vim.api.keyset.events|vim.api.keyset.events[], preload: boolean, build: function }

---@param spec (PackySpec|string)[]
---@return table|nil
local function resolve_spec(spec)
	local n = #spec
	if n == 0 then
		return nil
	end

	local resolved_spec = {}
	for i = 1, n do
		local plugin = spec[i]
		if type(plugin) == "string" then
			plugin = { src = plugin }
		end

		resolved_spec[i] = plugin
			and {
				src = plugin.src,
				name = plugin.name,
				version = plugin.version,
				data = {
					config = plugin.config,
					dir = plugin.dir,
					cond = plugin.cond == nil or plugin.cond,
					event = plugin.event,
					preload = plugin.preload or false,
					build = plugin.build,
				},
			}
	end
	return resolved_spec
end

---@param plug { spec: PackyResolvedSpec, path: string }
local function load(plug)
	local data = plug.spec.data
	if not data.cond then
		return
	end

	local function append_rtp()
		if data.dir and vim.uv.fs_stat(data.dir) then
			vim.opt.rtp:append(data.dir)
		else
			vim.opt.rtp:append(plug.path)
		end
	end

	if data.event then
		if data.preload then
			append_rtp()
			vim.api.nvim_create_autocmd(data.event, {
				once = true,
				callback = function()
					if data.config then
						data.config()
					end
				end,
			})
		else
			vim.api.nvim_create_autocmd(data.event, {
				once = true,
				callback = function()
					append_rtp()
					if data.config then
						data.config()
					end
				end,
			})
		end
		return
	end

	append_rtp()
	if data.config then
		data.config()
	end
	if data.build then
		vim.api.nvim_create_autocmd("PackChanged", {
			callback = function(ev)
				if ev.data.spec.name == plug.spec.name then
					data.build()
				end
			end,
		})
	end
end

local function setup_keybinds()
	vim.keymap.set("n", "<Leader>pu", vim.pack.update, { desc = "Update plugins" })
	vim.keymap.set("n", "<Leader>pr", function()
		vim.pack.update(nil, { target = "lockfile" })
	end, { desc = "Restore plugins from lockfile" })
	vim.keymap.set("n", "<Leader>pc", function()
		---@diagnostic disable-next-line: call-non-callable
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

---@param spec (PackySpec|string)[]
M.setup = function(spec)
	if not spec then
		return
	end

	M.resolved_spec = resolve_spec(spec)
	if M.resolved_spec then
		vim.pack.add(M.resolved_spec, { load = load })
	end

	vim.schedule(setup_keybinds)
end

return M

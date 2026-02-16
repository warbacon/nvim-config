local M = {}

local function get_project_root()
    local root = vim.fs.find(".git", { path = vim.fn.getcwd(), upward = true })[1]
    return root and vim.fs.dirname(root) or vim.fn.getcwd()
end

---@param path string
---@param content string
local function write_file(path, content)
    vim.fn.mkdir(vim.fs.dirname(path), "p")
    local file = io.open(path, "w")
    if not file then
        return false
    end

    file:write(content)
    file:close()
    return true
end

function M.build()
    local root = get_project_root()
    local colors = require("pino.colors").get()

    local current_script = debug.getinfo(1, "S").source:sub(2)
    local extra_path = vim.fs.dirname(current_script)

    local stats = { generated = 0, failed = 0 }

    for name, type in vim.fs.dir(extra_path) do
        if type == "file" and name:match("%.lua$") and name ~= "init.lua" then
            local module_name = name:gsub("%.lua$", "")
            local ok, plugin = pcall(require, "pino.extra." .. module_name)

            if ok then
                local gen_ok, result = pcall(plugin.generate, colors)

                if gen_ok and type(result) == "table" then
                    for _, output in ipairs(result) do
                        local dest_path = vim.fs.joinpath(root, "extras", module_name, output.filename)

                        if write_file(dest_path, output.content) then
                            vim.notify("Generated: " .. dest_path, vim.log.levels.INFO)
                            stats.generated = stats.generated + 1
                        else
                            vim.notify("Write failed: " .. dest_path, vim.log.levels.ERROR)
                            stats.failed = stats.failed + 1
                        end
                    end
                else
                    vim.notify("Generate failed: pino.extra." .. module_name, vim.log.levels.ERROR)
                    stats.failed = stats.failed + 1
                end
            else
                vim.notify("Load failed: pino.extra." .. module_name, vim.log.levels.ERROR)
                stats.failed = stats.failed + 1
            end
        end
    end

    vim.notify(
        string.format("Pino Extras: %d generated, %d failed", stats.generated, stats.failed),
        vim.log.levels.INFO
    )
end

return M

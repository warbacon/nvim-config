local M = {}

local function get_project_root()
    local current = debug.getinfo(1, "S").source:sub(2) -- Archivo actual
    local lua_dir = vim.fs.find("lua", {
        path = vim.fs.dirname(current),
        upward = true,
        type = "directory",
    })[1]

    if lua_dir then
        return vim.fs.dirname(lua_dir) -- Directorio padre de lua/
    end

    -- Fallback: buscar desde cwd
    local lua_dir_cwd = vim.fs.find("lua", {
        path = vim.fn.getcwd(),
        upward = true,
        type = "directory",
    })[1]

    return lua_dir_cwd and vim.fs.dirname(lua_dir_cwd) or nil
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

    if not root then
        vim.notify("Pino Extras: Could not find 'lua/' directory. Build cancelled.", vim.log.levels.ERROR)
        return
    end

    local colors = require("pino.colors").setup()

    -- Lista explícita de extras disponibles
    local extras = {
        "alacritty",
        "windows_terminal",
        "kitty",
        "ghostty",
        "foot",
    }

    local stats = { generated = 0, failed = 0 }

    for _, extra_name in ipairs(extras) do
        local ok, plugin = pcall(require, "pino.extra." .. extra_name)

        if ok then
            local gen_ok, result = pcall(plugin.generate, colors)

            if gen_ok and type(result) == "table" then
                for _, output in ipairs(result) do
                    local dest_path = vim.fs.joinpath(root, "extras", extra_name, output.filename)

                    if write_file(dest_path, output.content) then
                        vim.notify("Generated: " .. dest_path, vim.log.levels.INFO)
                        stats.generated = stats.generated + 1
                    else
                        vim.notify("Write failed: " .. dest_path, vim.log.levels.ERROR)
                        stats.failed = stats.failed + 1
                    end
                end
            else
                vim.notify("Generate failed: pino.extra." .. extra_name, vim.log.levels.ERROR)
                stats.failed = stats.failed + 1
            end
        else
            vim.notify("Load failed: pino.extra." .. extra_name, vim.log.levels.ERROR)
            stats.failed = stats.failed + 1
        end
    end

    vim.notify(
        string.format("Pino Extras: %d generated, %d failed", stats.generated, stats.failed),
        vim.log.levels.INFO
    )
end

return M

local M = {}

local function get_git_root()
    local null_device = vim.fn.has("win32") == 1 and "nul" or "/dev/null"
    local handle = io.popen("git rev-parse --show-toplevel 2>" .. null_device)
    if not handle then
        return vim.fn.getcwd()
    end
    local result = handle:read("*a")
    handle:close()
    result = result:gsub("[\n\r]", "")
    return result ~= "" and result or vim.fn.getcwd()
end

---@param path string
---@param content string
local function write_file(path, content)
    local dir = vim.fn.fnamemodify(path, ":h")
    vim.fn.mkdir(dir, "p")
    local file = io.open(path, "w")
    if file then
        file:write(content)
        file:close()
        return true
    end
    return false
end

function M.setup()
    local root = get_git_root()
    local palette = require("pino.palette")

    local extra_path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":h")

    local generated = 0
    local failed = 0

    for name, ftype in vim.fs.dir(extra_path) do
        if ftype == "file" and name:match("%.lua$") and name ~= "init.lua" then
            local module_name = name:gsub("%.lua$", "")
            local ok, plugin = pcall(require, "pino.extra." .. module_name)

            if ok then
                local success, result = pcall(plugin.generate, palette)

                if success and type(result) == "table" then
                    for _, output in ipairs(result) do
                        local filepath = root .. "/extras/" .. module_name .. "/" .. output.filename

                        if write_file(filepath, output.content) then
                            print(string.format("Generated: extras/%s/%s", module_name, output.filename))
                            generated = generated + 1
                        else
                            print(string.format("Failed to write: extras/%s/%s", module_name, output.filename))
                            failed = failed + 1
                        end
                    end
                else
                    print(string.format("Failed to generate: pino.extra.%s", module_name))
                    failed = failed + 1
                end
            else
                print(string.format("Failed to load: pino.extra.%s", module_name))
                failed = failed + 1
            end
        end
    end

    print(string.format("\nGenerated %d theme(s), %d failed", generated, failed))
end

return M

local M = {}

M.content = {}

M.file = vim.fs.joinpath(vim.fn.stdpath("cache"), "pino.json")

local function read_file(path)
    local fd = vim.uv.fs_open(path, "r", 438)
    if not fd then
        return
    end
    local stat = vim.uv.fs_fstat(fd)
    if not stat then
        vim.uv.fs_close(fd)
        return
    end
    local content = vim.uv.fs_read(fd, stat.size, 0)
    vim.uv.fs_close(fd)
    return content
end

M.setup = function()
    local opts = require("pino.config").options
    local inputs = {
        style = opts.style,
        plugins = opts.plugins,
    }

    local content = read_file(M.file)
    if content then
        local ok, decoded = pcall(vim.json.decode, content)
        if ok and decoded and vim.deep_equal(inputs, decoded.inputs) then
            M.content = decoded
        end
    end

    vim.api.nvim_create_user_command("PinoCache", M.clear, {})
end

---@param colors table<string,string>
---@param highlights table<string,vim.api.keyset.highlight>
---@param inputs table
M.write = function(colors, highlights, inputs)
    M.content = { colors = colors, highlights = highlights, inputs = inputs }
    require("pino.util").write_file(M.file, vim.json.encode(M.content))
end

M.clear = function()
    vim.uv.fs_unlink(
        M.file,
        vim.schedule_wrap(function()
            vim.notify("Pino cache cleared!")
        end)
    )
end

return M

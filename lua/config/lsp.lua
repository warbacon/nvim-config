local lsp_path = vim.fs.joinpath(vim.fn.stdpath("config"), "lsp")

if not vim.uv.fs_stat(lsp_path) then
    return
end

local servers = {}
for name, type in vim.fs.dir(lsp_path) do
    if type == "file" then
        local basename = vim.fs.basename(name)
        local server_name = basename:match("(.+)%..+")
        if server_name then
            table.insert(servers, server_name)
        end
    end
end

vim.lsp.config("*", {
    root_markers = { ".git" },
})

vim.lsp.enable(servers)

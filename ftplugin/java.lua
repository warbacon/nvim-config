local has_jdtls, jdtls = pcall(require, "jdtls")

if not has_jdtls then
    return
end

local config = {
    cmd = { "jdtls" },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}

jdtls.start_or_attach(config)

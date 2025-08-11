local has_jdtls, jdtls = pcall(require, "jdtls")

if not has_jdtls or vim.fn.executable("java") == 0 or vim.fn.executable("jdtls") == 0 then
    return
end

local has_blink_cmp, blink_cmp = pcall(require, "blink.cmp")

local config = {
    cmd = { "jdtls" },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
    capabilities = has_blink_cmp and blink_cmp.get_lsp_capabilities() or {},
}

jdtls.start_or_attach(config)

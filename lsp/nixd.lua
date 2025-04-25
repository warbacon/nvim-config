---@type vim.lsp.Config
return {
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            options = {
                nixos = {
                    expr = string.format(
                        'import (builtins.getFlake "%s/Git/nixos-config").nixosConfigurations.%s.options',
                        vim.env.HOME,
                        vim.fn.hostname()
                    ),
                },
            },
        },
    },
}

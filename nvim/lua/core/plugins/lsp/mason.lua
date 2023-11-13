return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function ()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                }
            }
        })

        mason_lspconfig.setup({
            -- Language servers to install
            ensure_installed = {
                "tsserver",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "emmet_ls",
                "pyright",
                "arduino_language_server",
                "asm_lsp",
                "cland",
                "csharp_ls",
                "bashls",
                "cmake",
                "dockerls",
                "docker_compose_language_server",
                "eslint",
                "jsonls",
                "rust_analyzer",
                "sqlls",
            },
            -- auto-install configured servers
            automatic_installation = true,
        })
    end,
}

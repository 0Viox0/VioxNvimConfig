return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "somesass_ls",
                "lua_ls",
                "clangd",
                "emmet_ls",
                "bashls",
                "lemminx",
                -- "omnisharp", -- enable it if you need it (there is lsp rule for go to definition)
                "tailwindcss",
            },
            automatic_installation = true,
        })
    end,
}

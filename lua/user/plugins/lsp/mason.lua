return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim"
    },
    config = function()
        local mason = require("mason")

        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({})

        mason_lspconfig.setup({
            ensure_installed = {
                "basedpyright",
                "ruff",
                "lua_ls",
                "bashls",
                "html",
                "ts_ls",
                "eslint",
                "taplo",
            },
        })
    end,
}

return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<A-i>",
                    node_incremental = "<A-i>",
                    scope_incremental = false,
                    node_decremental = "<A-I>",
                },
            },
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "html",
                "python",
                "bash",
                "groovy",
                "dockerfile",
            },
        })
    end
}

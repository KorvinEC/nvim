return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function ()
        local kanagawa = require("kanagawa")

        kanagawa.setup({
            theme = "wave",
        })

        vim.cmd("colorscheme kanagawa-dragon")
    end
}

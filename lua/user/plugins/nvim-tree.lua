return {
    "nvim-tree/nvim-tree.lua",
    config = function ()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true

        local nvim_tree = require("nvim-tree")

        -- empty setup using defaults
        nvim_tree.setup({
            view = {
                number = true,
                relativenumber = true,
            },
            renderer = {
                add_trailing = true,
                group_empty = true,
                highlight_git = "all",
            },
            git = {
                ignore = false,
            },
            tab = {
                sync = {
                    open = true,
                },
            },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        keymap.set("n", "<leader>T", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    end
}

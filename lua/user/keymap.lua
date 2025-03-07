vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<C-_>", "gcc", { remap = true })
keymap.set("v", "<C-_>", "gcc", { remap = true })

keymap.set("n", "<leader>ol", "<cmd>Lazy<CR>", { desc = "Open Lazy" })
keymap.set("n", "<leader>om", "<cmd>Mason<CR>", { desc = "Open Mason" })

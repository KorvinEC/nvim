vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>ol", "<cmd>Lazy<CR>", { desc = "Open Lazy" })
keymap.set("n", "<leader>om", "<cmd>Mason<CR>", { desc = "Open Mason" })


keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Write file" })
keymap.set("n", "<leader>W", "<cmd>write!<CR>", { desc = "Force write file" })

vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<C-_>", "gcc", { remap = true })
keymap.set("v", "<C-_>", "gcc", { remap = true })

keymap.set("n", "J", "mzJ`z")

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<C-b>k", "<cmd>bnext<CR>")
keymap.set("n", "<C-b>j", "<cmd>bprevious<CR>")
keymap.set("n", "<C-b>h", "<cmd>bfirst<CR>")
keymap.set("n", "<C-b>l", "<cmd>blast<CR>")
keymap.set("n", "<C-b>s", "<cmd>ls<CR>")
keymap.set("n", "<C-b>x", "<cmd>bdelete<CR>")

keymap.set("n", "<leader>ol", "<cmd>Lazy<CR>", { desc = "Open Lazy" })
keymap.set("n", "<leader>om", "<cmd>Mason<CR>", { desc = "Open Mason" })

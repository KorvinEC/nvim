vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-web-devicons.git"
})

local fzf = require("fzf-lua")

fzf.setup({
  fzf_colors = true
})

local keymap = vim.keymap

keymap.set("n", "<leader>ff", fzf.files, { desc = "Find Files" })
keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Grep" })
keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
keymap.set("n", "<leader>f/", fzf.helptags, { desc = "Help tags" })
keymap.set("n", "<leader>fr", fzf.registers, { desc = "Registers" })

keymap.set("n", "grr", fzf.lsp_references, { desc = "References" })
keymap.set("n", "gd", fzf.lsp_definitions, { desc = "Definition" })
keymap.set("n", "gD", fzf.lsp_declarations, { desc = "Declaration" })
keymap.set("n", "gi", fzf.lsp_implementations, { desc = "Implementation" })
keymap.set("n", "gi", fzf.lsp_typedefs, { desc = "Type Definitions" })

keymap.set("v", "<leader>f", fzf.grep_visual, { desc = "Grep visual selection" })

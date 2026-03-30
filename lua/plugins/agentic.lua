vim.pack.add({
  "https://github.com/carlos-algms/agentic.nvim",
})

require("agentic").setup({
  provider = "opencode-acp"
})

vim.keymap.set({ "n", "v", "i" }, "<leader>oo", function() require("agentic").toggle() end, { desc = "Toggle Opencode" })

vim.pack.add({
  "https://github.com/folke/which-key.nvim"
})

local which_key = require("which-key")

which_key.setup({
  spec = {
    { "<leader>z", group = " Trouble toggles" },
    { "<leader>o", group = " Open menu" },
    { "<leader>n", group = " Avante LLM" },
    { "<leader>f", group = " Picker" }
  }
})

vim.o.timeout = true
vim.o.timeoutlen = 500

which_key.add({
  { "<leader>y", group = "Yank file part" },
})

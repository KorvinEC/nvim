vim.pack.add({
  "https://github.com/kndndrj/nvim-dbee",
  "https://github.com/MunifTanjim/nui.nvim",
})

local dbee = require("dbee")

dbee.setup()

vim.keymap.set("n", "<leader>oe", dbee.toggle, { desc = "Toggle Dbee" })

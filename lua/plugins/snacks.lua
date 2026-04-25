vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local snacks = require("snacks")

snacks.setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  bigfile = { enabled = true },
  input = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 2, total = 250 }
    },
  },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  animate = { enabled = true },
  bufdelete = { enabled = true },
  picker = { enabled = false },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = false },
  image = { enabled = false },
  notifier = { enabled = false }
})

local keymap = vim.keymap

keymap.set("n", "<leader>bd", function() snacks.bufdelete() end, { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", function() snacks.bufdelete.other() end, { desc = "Delete all other buffers" })

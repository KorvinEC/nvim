vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

local render_markdown = require("render-markdown")

render_markdown.setup()

vim.keymap.set("n", "<leader>bm", render_markdown.buf_toggle,
  { desc = "Toggle render markdown" })

vim.keymap.set("n", "<leader>bp", render_markdown.preview,
  { desc = "Toggle render markdown" })

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvimtreesitter/nvim-treesitter' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  init = function()
    local render_markdown = require("render-markdown")

    vim.keymap.set("n", "<leader>bm", render_markdown.buf_toggle,
      { desc = "Toggle render markdown" })

    vim.keymap.set("n", "<leader>bp", render_markdown.preview,
      { desc = "Toggle render markdown" })
  end
}

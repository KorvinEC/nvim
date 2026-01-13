return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { { 'nvim-treesitter/nvim-treesitter', branch = "master"}, 'echasnovski/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  init = function()
    vim.keymap.set("n", "<leader>bm", ":RenderMarkdown buf_toggle<CR>",
      { desc = "Toggle render markdown" })
  end
}

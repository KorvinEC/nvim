return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    spec = {
      { "<leader>z", group = " Trouble toggles" },
      { "<leader>o", group = " Open menu" },
    },
  },
}

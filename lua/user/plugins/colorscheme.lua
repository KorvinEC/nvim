return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  init = function()
    vim.o.background = "dark" -- or "light" for light mode
    vim.cmd([[colorscheme gruvbox]])
  end,
  opts = {
    overrides = {
      WinSeparator = { fg = "#5a633a" }
    }
  }
}

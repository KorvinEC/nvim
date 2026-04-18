vim.pack.add({
  "https://github.com/brenoprata10/nvim-highlight-colors",
})

require("nvim-highlight-colors").setup({
  render = "virtual",
  virtual_symbol_position = 'eow',
  virtual_symbol = '',
  virtual_symbol_prefix = ' ',
  virtual_symbol_suffix = ' ',
  exclude_filetypes = { "lazy" }
})

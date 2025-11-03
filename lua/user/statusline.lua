local gruvbox = require("gruvbox")
local palette = gruvbox.palette

vim.cmd.hi(
  string.format(
    "WinBar guifg=%s guibg=%s",
    palette.bright_green,
    palette.dark0
  )
)

vim.cmd.hi(
  string.format(
    "WinBarNC guifg=%s guibg=%s",
    palette.dark_green,
    palette.dark0
  )
)

vim.cmd([[set winbar=[%n]\ %<%f\ %h%w%m%r%=%l\ \|\ %c%V]])
vim.cmd([[set statusline=%<%t%=%P\ %y]])

vim.opt.laststatus = 3

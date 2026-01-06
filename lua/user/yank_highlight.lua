local colors = require("gruvbox").palette

vim.api.nvim_set_hl(0, "YankHighlight", {
  fg = colors.dark_green_hard,
  bg = colors.light_aqua_soft
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.hl.on_yank {
      higroup = 'YankHighlight',
      timeout = 500,
      on_visual = true
    }
  end,
})

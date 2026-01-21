return {
  'mrjones2014/smart-splits.nvim',
  opts = {
    move_cursor_same_row = false,
    zellij_move_focus_or_tab = true,
  },
  init = function()
    local sp = require("smart-splits")

    -- moving between splits
    vim.keymap.set('n', '<A-h>', sp.move_cursor_left)
    vim.keymap.set('n', '<A-j>', sp.move_cursor_down)
    vim.keymap.set('n', '<A-k>', sp.move_cursor_up)
    vim.keymap.set('n', '<A-l>', sp.move_cursor_right)

    vim.keymap.set('n', '<A-Left>', sp.resize_left)
    vim.keymap.set('n', '<A-Down>', sp.resize_down)
    vim.keymap.set('n', '<A-Up>', sp.resize_up)
    vim.keymap.set('n', '<A-Right>', sp.resize_right)

    vim.keymap.set('n', '<A-\\>', sp.move_cursor_previous)

    -- swapping buffers between windows
    vim.keymap.set('n', '<leader><leader>h', sp.swap_buf_left, { desc = "Swap buffer to left" })
    vim.keymap.set('n', '<leader><leader>j', sp.swap_buf_down, { desc = "Swap buffer to down" })
    vim.keymap.set('n', '<leader><leader>k', sp.swap_buf_up, { desc = "Swap buffer to up" })
    vim.keymap.set('n', '<leader><leader>l', sp.swap_buf_right, { desc = "Swap buffer to right" })
  end
}

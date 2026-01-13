return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  config = function()
    local dbee = require("dbee")

    dbee.setup()

    vim.keymap.set('n', '<leader>oe', dbee.toggle, { desc = "Toggle Dbee" })
  end,
  keys = {
    { '<leader>oe', mode = 'n', desc = 'Toggle Dbee' }
  },
}

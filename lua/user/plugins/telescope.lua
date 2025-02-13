return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  tag = '0.1.8',
  config = function()
    -- setup telescope
    local telescope = require("telescope")

    -- This line should be before usual (normal) setup
    telescope.setup({ defaults = require('telescope.themes').get_ivy() })
  end,
}

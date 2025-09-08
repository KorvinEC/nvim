return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for a better input and embedded terminal experience.
    -- To bypass: use your own `toggle` (if any), and override `opts.on_send` and `opts.on_opencode_not_found`.
    { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
    {
      "cbochs/grapple.nvim",
      dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
    }
  },
  ---@type opencode.Opts
  opts = {
    -- Your configuration, if any
  },
  keys = {
    -- Recommended keymaps
    { '<leader>aa', function() require('opencode').ask('@cursor: ') end,    desc = 'Ask opencode',                 mode = 'n', },
    { '<leader>aa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
    { '<leader>ap', function() require('opencode').select_prompt() end,     desc = 'Select prompt',                mode = { 'n', 'v', }, },
  },
}

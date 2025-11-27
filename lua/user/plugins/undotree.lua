return {
  "jiaoshijie/undotree",
  ---@module 'undotree.collector'
  ---@type UndoTreeCollector.Opts
  opts = {
    -- your options
  },
  keys = { -- load the plugin only when using it's keybinding:
    { "<leader>ou", "<cmd>lua require('undotree').toggle()<cr>" },
  },
  config = function()
    vim.opt.undofile = true
  end
}

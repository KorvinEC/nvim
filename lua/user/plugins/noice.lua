return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      name = "notify",
      opts = {
        top_down = false,
        stages = "static",
        -- stylua: ignore
        max_height = function() return math.floor(vim.o.lines * 0.75) end,
        -- stylua: ignore
        max_width = function() return math.floor(vim.o.columns * 0.75) end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { focusable = false })
        end,
      },
    },
  },
}

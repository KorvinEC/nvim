return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "s",         mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "<leader>r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "<leader>R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
  config = function()
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#282828", bg = "#cc241d" })
  end
}

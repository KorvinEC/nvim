vim.pack.add({
  "https://github.com/folke/flash.nvim",
})

local colors = require("gruvbox").palette

vim.api.nvim_set_hl(0, "FlashLabelHighlight", {
  fg = colors.bright_aqua,
  bg = colors.dark_aqua_hard
})

require("flash").setup({
  label = {
    ---@type fun(opts:Flash.Format): string[][]
    format = function(opts)
      return {
        { opts.match.label, "FlashLabelHighlight" }
      }
    end
  },
})

vim.keymap.set({ "n", "x", "o" }, "<C-s>", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "<C-t>", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })

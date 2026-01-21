return {
  "folke/flash.nvim",
  event = { "VeryLazy" },
  dependencies = { "folke/snacks.nvim" },
  keys = {
    { "<C-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "<C-t>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
  specs = {
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          win = {
            input = {
              keys = {
                ["<a-s>"] = { "flash", mode = { "n", "i" } },
                ["s"] = { "flash" },
              },
            },
          },
          actions = {
            flash = function(picker)
              require("flash").jump({
                pattern = "^",
                label = { after = { 0, 0 } },
                search = {
                  mode = "search",
                  exclude = {
                    function(win)
                      return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                    end,
                  },
                },
                action = function(match)
                  local idx = picker.list:row2idx(match.pos[1])
                  picker.list:_move(idx, true, true)
                end,
              })
            end,
          },
        },
      },
    },
  },
  config = function()
    local colors = require("gruvbox").palette

    local flash = require("flash")

    vim.api.nvim_set_hl(0, "FlashLabelHighlight", {
      fg = colors.bright_aqua,
      bg = colors.dark_aqua_hard
    })

    flash.setup({
      label = {
        ---@type fun(opts:Flash.Format): string[][]
        format = function(opts)
          return {
            { opts.match.label, "FlashLabelHighlight" }
          }
        end
      },
    })
  end
}

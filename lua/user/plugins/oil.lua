return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-y>"] = "actions.select",

        ["<leader>v"] = { "actions.select", opts = { vertical = true, split = "belowright" } },
        ["<leader>s"] = { "actions.select", opts = { horizontal = true, split = "belowright" } },
        ["<leader>t"] = { "actions.select", opts = { tab = true } },

        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },

        ["<C-p>"] = "actions.preview",

        ["q"] = { "actions.close", mode = "n" },

        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },

        ["gl"] = "actions.refresh",
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
    })
    vim.keymap.set("n", "<leader>T", "<cmd>Oil<CR>")
  end
}

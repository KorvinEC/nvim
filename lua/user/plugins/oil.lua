local select_function = function()
  local oil = require("oil")
  local current_entry = oil.get_cursor_entry()

  if current_entry ~= nil and current_entry.type == "directory" then
    local current_buffer = vim.api.nvim_get_current_buf()

    vim.schedule(
      function()
        vim.api.nvim_buf_delete(current_buffer, {})
      end
    )
  end

  oil.select()
end

local parent_function = function()
  local oil = require("oil")

  local current_buffer = vim.api.nvim_get_current_buf()

  vim.schedule(
    function()
      vim.api.nvim_buf_delete(current_buffer, {})
    end
  )

  oil.open()
end

return {
  'stevearc/oil.nvim',
  opts = {
    columns = {
      "permissions",
      "size",
      "mtime",
      "icon",
    },
    buf_options = {
      buflisted = true,
      bufhidden = "hide"
    },
    win_options = {
      wrap = false,
      signcolumn = "yes",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },
    cleanup_delay_ms = false,
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = { select_function },
      ["<C-y>"] = { select_function, opts = { close = true } },

      ["<leader>v"] = { "actions.select", opts = { vertical = true, split = "belowright" } },
      ["<leader>s"] = { "actions.select", opts = { horizontal = true, split = "belowright" } },
      ["<C-q>"] = { "actions.send_to_qflist", opts = { action = "r", only_matching_search = true, target = "qflist" } },

      ["-"] = { parent_function, mode = "n" },
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
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  init = function()
    vim.keymap.set("n", "<leader>T", "<cmd>Oil<CR>")
  end
}

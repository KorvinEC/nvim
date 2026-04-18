vim.pack.add({
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons.git"
})

local snacks = require("snacks")

snacks.setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  picker = {
    enabled = true,
    matcher = {
      fuzzy = true,
      frecency = true,
    },
    formatters = {
      file = {
        filename_first = true,
        truncate = 500,
      },
    },
    win = {
      input = {
        keys = {
          ["<C-y>"] = { "confirm", mode = { "n", "i" } },
          ["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
          ["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
        }
      },
      list = {
        keys = {
          ["<C-y>"] = { "confirm", mode = { "n", "i" } },
          ["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
          ["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
        }
      },
    },
    layouts = {
      custom_select = {
        -- hidden = { "preview" },
        layout = {
          backdrop = false,
          row = 2,
          width = 0.4,
          min_width = 80,
          max_width = 100,
          height = 0.4,
          min_height = 2,
          box = "vertical",
          border = true,
          title = "{title}",
          title_pos = "center",
          { win = "input",   height = 1,          border = "bottom" },
          { win = "list",    border = "none" },
          { win = "preview", title = "{preview}", height = 0.1,     border = "top" },
        },
      }
    }
  },
  notifier = { enabled = false },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 2, total = 250 }
    },
  },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  animate = { enabled = true },
  bufdelete = { enabled = true },
  image = { enabled = false }
})

local keymap = vim.keymap

keymap.set("n", "<leader>ol", vim.pack.update, { desc = "Open VimPack update" })
keymap.set("n", "<leader>ff", function() snacks.picker.files({ hidden = true }) end, { desc = "Find Files" })
keymap.set("n", "<leader>fs", function() snacks.picker.git_status() end, { desc = "Git Status" })
keymap.set("n", "<leader>fb", function() snacks.picker.buffers() end, { desc = "Buffers" })
keymap.set("n", "<leader>fn", function() snacks.picker.notifications() end, { desc = "Notification History" })
keymap.set("n", "<leader>fh", function() snacks.picker.command_history() end, { desc = "Command History" })
keymap.set("n", '<leader>fr"', function() snacks.picker.registers() end, { desc = "Registers" })
keymap.set("n", "<leader>fg", function() snacks.picker.grep() end, { desc = "Grep" })
keymap.set("n", "<leader>fw", function() snacks.picker.grep_word() end, { desc = "Visual selection or word" })
keymap.set("n", "<leader>f/", function() snacks.picker.help() end, { desc = "Help Pages" })
keymap.set("n", "<leader>fl", function() snacks.picker.lines() end, { desc = "Jump to highlighted" })
keymap.set("n", "<leader>bd", function() snacks.bufdelete() end, { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", function() snacks.bufdelete.other() end, { desc = "Delete all other buffers" })
keymap.set("n", "grr", function() snacks.picker.lsp_references() end, { desc = "References" })
keymap.set("n", "gd", function() snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
keymap.set("n", "gD", function() snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
keymap.set("n", "gi", function() snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
keymap.set("n", "gt", function() snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })

local function fuzzy_oil()
  local find_command = {
    'fd',
    '--type',
    'd',
  }

  vim.fn.jobstart(find_command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        local filtered = vim.tbl_filter(function(el)
          return el ~= ''
        end, data)

        local items = {}
        for _, v in ipairs(filtered) do
          table.insert(items, { text = v, file = v })
        end

        ---@module 'snacks'
        Snacks.picker.pick(
          {
            source = 'directories',
            items = items,
            format = 'text',
            confirm = function(picker, item)
              picker:close()
              vim.cmd('Oil ' .. item.text)
            end,
          }
        )
      end
    end,
  })
end

keymap.set("n", "<leader>fF", fuzzy_oil, { desc = "Find Folders" })

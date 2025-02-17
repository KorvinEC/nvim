return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
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
        },
      },
    },
    notifier = { enabled = true },
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
    animate = { enabled = true, },
  },
  keys = {
    { "<leader><space>", function() Snacks.picker.smart() end,                desc = "Smart Find Files" },

    { "<leader>ff",      function() Snacks.picker.files() end,                desc = "Find Files" },
    { "<leader>fs",      function() Snacks.picker.git_status() end,           desc = "Git Status" },
    { "<leader>fb",      function() Snacks.picker.buffers() end,              desc = "Buffers" },
    { "<leader>fn",      function() Snacks.picker.notifications() end,        desc = "Notification History" },
    { "<leader>fh",      function() Snacks.picker.command_history() end,      desc = "Command History" },
    { '<leader>fr"',     function() Snacks.picker.registers() end,            desc = "Registers" },
    { "<leader>fg",      function() Snacks.picker.grep() end,                 desc = "Grep" },
    { "<leader>fw",      function() Snacks.picker.grep_word() end,            desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>f/",      function() Snacks.picker.help() end,                 desc = "Help Pages" },

    { "<leader>og",      function() Snacks.lazygit() end,                     desc = "Open Lazygit" },

    { "gr",              function() Snacks.picker.lsp_references() end,       nowait = true,                     desc = "References" },
    { "gd",              function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
    { "gD",              function() Snacks.picker.lsp_declarations() end,     desc = "Goto Declaration" },
    { "gi",              function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
    { "gt",              function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  },
}

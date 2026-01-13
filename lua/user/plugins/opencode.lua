return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      select = {
        prompt = "opencode: ",
        sections = {
          prompts = true,
          commands = {
            ["session.new"] = "Start a new session",
            ["session.share"] = "Share the current session",
            ["session.interrupt"] = "Interrupt the current session",
            ["session.compact"] = "Compact the current session (reduce context size)",
            ["session.undo"] = "Undo the last action in the current session",
            ["session.redo"] = "Redo the last undone action in the current session",
            ["agent.cycle"] = "Cycle the selected agent",
          },
          provider = true,
        },
        snacks = {
          preview = "preview",
          layout = {
            preset = "custom_select",
          },
        },
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    vim.keymap.set("n", '<leader>aa', function() require('opencode').ask('@cursor: ') end, { desc = 'Ask opencode' })
    vim.keymap.set("v", '<leader>aa', function() require('opencode').ask('@selection: ') end,
      { desc = 'Ask opencode about selection' })
    vim.keymap.set({ "n", "v" }, '<leader>ap', function() require('opencode').select() end, { desc = 'Select prompt' })
  end,
  keys = {
    { "<leader>aa", mode = { "n", "v" }, desc = 'Ask opencode' },
    { "<leader>ap", mode = { "n", "v" }, desc = 'Select prompt' },
  },
}

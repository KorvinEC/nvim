return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',  build = "make" },
    { "debugloop/telescope-undo.nvim" },
    { "folke/which-key.nvim" },
    { 'nvim-tree/nvim-web-devicons' },
    { "nvim-telescope/telescope-file-browser.nvim" }
  },
  tag = '0.1.8',
  config = function()
    -- setup telescope
    local telescope = require("telescope")

    local actions = require("telescope.actions")
    local undo_actions = require("telescope-undo.actions")

    -- This line should be before usual (normal) setup
    telescope.setup({ defaults = require('telescope.themes').get_ivy() })

    telescope.setup({
      defaults = {
        layout_config = { height = 0.80 },
        mappings = {
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
          },
          n = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["q"] = actions.close,
          },
        },
        require("telescope.themes").get_ivy(),
      },
      pickers = {
        diagnostics = { initial_mode = "normal" },
        git_status = { initial_mode = "normal" },
        buffers = {
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                             -- false will only do exact matching
          override_generic_sorter = true,           -- override the generic sorter
          override_file_sorter = true,              -- override the file sorter
          case_mode = "smart_case",                 -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        undo = {
          use_delta = true,
          use_custom_command = nil,           -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
          side_by_side = false,
          vim_diff_opts = {
            ctxlen = vim.o.scrolloff,
          },
          entry_format = "state #$ID, $STAT, $TIME",
          time_format = "",
          saved_only = false,
          mappings = {
            i = {
              ["<cr>"] = undo_actions.restore,
              ["<S-cr>"] = undo_actions.yank_deletions,
              ["<C-cr>"] = undo_actions.yank_additions,
              -- alternative defaults, for users whose terminals do questionable things with modified <cr>
              ["<C-y>"] = undo_actions.yank_deletions,
              ["<C-r>"] = undo_actions.restore,
            },
            n = {
              ["y"] = undo_actions.yank_additions,
              ["Y"] = undo_actions.yank_deletions,
              ["u"] = undo_actions.restore,
            },
          },
        },
      }
    })

    telescope.load_extension("fzf")
    telescope.load_extension("undo")
    telescope.load_extension("noice")
    telescope.load_extension("file_browser")

    local keymap = vim.keymap
    local builtin = require('telescope.builtin')

    keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Files" })
    keymap.set('n', '<leader>fr', builtin.registers, { desc = "Registers" })
    keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Old files" })
    keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
    keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = "Current buffer fuzzy find" })
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
    keymap.set('n', '<leader>f/', builtin.help_tags, { desc = "Help" })
    keymap.set('n', '<leader>fu', telescope.extensions.undo.undo, { desc = "Undo" })
    keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Git status" })
    keymap.set("n", "<leader>fn", "<cmd>Noice telescope<CR>", { desc = "Noice (last messages)" })
    keymap.set("n", "<leader>fh", builtin.command_history, { desc = "Command history" })
    keymap.set("n", "<leader>fd", function()
      builtin.diagnostics({ bufnr = 0 })
    end, { desc = "Current buffer diagnostics" })
    keymap.set("n", "<leader>ft", function()
      telescope.extensions.file_browser.file_browser()
    end, { desc = "File browser" })
    keymap.set("n", "<leader>fT", function()
      telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        select_buffer = true,
      })
    end, { desc = "File browser current buffer" })

    local which_key = require("which-key")

    which_key.add({
      { "<leader>f", group = " Telescope search" }
    })
  end,
}

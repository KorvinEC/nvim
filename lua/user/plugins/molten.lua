return {
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    config = true,
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" },
    config = function()
      ---@module 'quarto'
      require("quarto").setup({
        lspFeatures = {
          languages = { "python" },
          chunks = "all",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "H",
          definition = "gd",
          rename = "<leader>lr",
          references = "gr",
          format = "<leader>lf",
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        }
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "quarto", "markdown" },
        callback = function(event)
          local runner = require("quarto.runner")

          vim.keymap.set("n", "<leader>r", runner.run_cell,
            { buffer = event.buf, desc = "Run cell (Quarto)", silent = true })
          vim.keymap.set("n", "<leader>ma", runner.run_above,
            { buffer = event.buf, desc = "Run cell and above (Quarto)", silent = true })
          vim.keymap.set("n", "<leader>mA", runner.run_all,
            { buffer = event.buf, desc = "Run all cells (Quarto)", silent = true })
          vim.keymap.set("n", "<leader>ml", runner.run_line,
            { buffer = event.buf, desc = "Run line (Quarto)", silent = true })
          vim.keymap.set("v", "<leader>r", runner.run_range,
            { buffer = event.buf, desc = "Run visual range (Quarto)", silent = true })
        end,
      })
    end
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim", "quarto-dev/quarto-nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true

      vim.g.molten_output_win_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

      vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim_molten/bin/python3")

      local which_key = require("which-key")

      which_key.add({
        { "<leader>m", group = " Molten group" },
      })

      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "initialize Molten" })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function(event)
          vim.keymap.set("n", "<leader>mr", ":MoltenEvaluateOperator<CR>",
            { buffer = event.buf, silent = true, desc = "run operator selection" })
          vim.keymap.set("n", "<leader>mR", ":MoltenReevaluateCell<CR>",
            { buffer = event.buf, silent = true, desc = "Re-evaluate cell" })
          vim.keymap.set("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv",
            { buffer = event.buf, silent = true, desc = "evaluate visual selection" })

          vim.keymap.set("n", "<leader>mL", ":MoltenEvaluateLine<CR>",
            { buffer = event.buf, silent = true, desc = "Evaluate line" })
          vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>",
            { buffer = event.buf, silent = true, desc = "Delete cell" })
          vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>",
            { buffer = event.buf, silent = true, desc = "Hide output" })
          vim.keymap.set("n", "<leader>mx", ":MoltenInterrupt<CR>",
            { buffer = event.buf, silent = true, desc = "Stop running code" })
          vim.keymap.set("n", "<leader>mb", ":MoltenOpenInBrowser<CR>",
            { buffer = event.buf, silent = true, desc = "Open in browser" })
          vim.keymap.set("n", "<leader>mi", ":MoltenImagePopup<CR>",
            { buffer = event.buf, silent = true, desc = "Open in browser" })

          vim.keymap.set("n", "<leader>mo", ":noautocmd MoltenEnterOutput<CR>",
            { buffer = event.buf, silent = true, desc = "Open output" })
        end,
      })
    end,
  }
}

return {
  'stevearc/conform.nvim',
  opts = {
    formatters = {
      python = {
        "ruff_organize_imports",
      }
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  init = function()
    vim.keymap.set("n", "<space>lf", function()
      require("conform").format({ async = true })
    end, { desc = "Format" })
  end
}

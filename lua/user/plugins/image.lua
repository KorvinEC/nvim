return {
  "3rd/image.nvim",
  build = false,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "markdown" },
          highlight = { enable = true },
        })
      end,
    },
  },
  event = "VeryLazy",
  opts = {
    backend = "ueberzug",

    max_width = 100,
    max_height = 12,
    max_height_window_percentage = math.huge,
    max_width_window_percentage = math.huge,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

    integrations = {
      markdown = {
        enabled = true,

        only_render_image_at_cursor_mode = "inline",

        filetypes = { "markdown" },
      },
      html = {
        enabled = true,
      },
      css = {
        enabled = true,
      },
    }
  },
}

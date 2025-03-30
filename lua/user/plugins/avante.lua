return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  opts = {
    provider = "claude",
    mappings = {
      ask = "<leader>na",
      edit = "<leader>ne",
      refresh = "<leader>nr",
      focus = "<leader>nf",
      stop = "<leader>nS",
      toggle = {
        default = "<leader>nt",
        debug = "<leader>nd",
        hint = "<leader>nh",
        suggestion = "<leader>ns",
        repomap = "<leader>nR",
      },
      files = {
        add_current = "<leader>nc",
        add_all_buffers = "<leader>nB",
      },
      select_model = "<leader>n?",
      select_history = "<leader>nh",
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

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
      new_ask = "<leader>nn",
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
    web_search_engine = {
      provider = "tavily",
      proxy = nil,
    },
    claude = {
      timeout = 5000,
    },
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub:get_active_servers_prompt()
    end,
    -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
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
    "ravitemer/mcphub.nvim"
  }
}

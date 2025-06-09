return {
  {
    'echasnovski/mini.comment',
    version = '*',
    config = function()
      require("mini.comment").setup({
        mappings = {
          comment = 'gc',
          comment_line = 'gcc',
          comment_visual = 'gc',
          textobject = 'gc',
        }
      })
    end
  },
  {
    'echasnovski/mini.move',
    version = '*',
    config = function()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<C-h>',
          right = '<C-l>',
          down = '<C-j>',
          up = '<C-k>',

          -- Cove current line in Normal mode
          line_left = '<C-h>',
          line_right = '<C-l>',
          line_down = '<C-j>',
          line_up = '<C-k>',
        },
      })
    end
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    config = function()
      require('mini.pairs').setup({
        modes = { insert = true, command = true, terminal = false }
      })
    end
  },
  {
    'echasnovski/mini.splitjoin',
    version = '*',
    config = function()
      require('mini.splitjoin').setup()
    end
  },
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      local mini_files = require("mini.files")

      mini_files.setup({
        options = {
          use_as_default_explorer = false,
        }
      })

      vim.keymap.set(
        "n",
        "<leader>t",
        function()
          mini_files.open(vim.api.nvim_buf_get_name(0), false)
          mini_files.reveal_cwd()
        end
      )

      local which_key = require("which-key")

      which_key.add({
        { "<leader>t", group = "Mini files" },
      })
    end
  },
  {
    {
      'echasnovski/mini.ai',
      version = '*',
      config = function()
        require("mini.ai").setup()
      end
    },
  },
  {
    {
      'echasnovski/mini.bracketed',
      version = '*',
      config = function()
        require("mini.bracketed").setup()
      end
    },
  },
  {
    {
      'echasnovski/mini.surround',
      version = '*',
      config = function()
        require("mini.surround").setup()

        vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
      end
    },
  }
}

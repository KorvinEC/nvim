return {
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
    end
  }
}

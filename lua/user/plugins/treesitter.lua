return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "master",
    },
    "folke/which-key.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      auto_install = true,
      modules = {},
      ignore_install = {},

      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "bash",
        "groovy",
        "dockerfile",
        "json",
        "javascript",
        "typescript",
        "html",
        "css",
        "tsx",
        "toml",
        "yaml",
        "sql",
        "diff",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "jq",
        "comment",
        "rust",
        "glsl",
        "regex"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = false,
          node_decremental = "<C-p>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = { query = "@parameter.outer", desc = "Outer argument (parameter)" },
            ["ia"] = { query = "@parameter.inner", desc = "Inner argument (parameter)" },

            ["af"] = { query = "@function.outer", desc = "Outer function" },
            ["if"] = { query = "@function.inner", desc = "Inner function" },

            ["ao"] = { query = "@class.outer", desc = "Outer object (class)" },
            ["io"] = { query = "@class.inner", desc = "Inner object (class)" },

            ["a/"] = { query = "@comment.outer", desc = "Outer comment" },
            ["i/"] = { query = "@comment.inner", desc = "Inner comment" },

            ["au"] = { query = "@type.outer", desc = "Outer type" },
            ["iu"] = { query = "@type.inner", desc = "Inner type" },

            ["am"] = { query = "@code_cell.outer", desc = "Outer code block" },
            ["im"] = { query = "@code_cell.inner", desc = "Inner code block" },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>san"] = { query = "@parameter.inner", desc = "Argument (parameter) with next" },
            ["<leader>sfn"] = { query = "@function.outer", desc = "Function with next" },
            ["<leader>smn"] = { query = "@code_cell.outer", desc = "Code block with next" },
          },
          swap_previous = {
            ["<leader>sap"] = { query = "@parameter.inner", desc = "Arguments (parameter) with previous" },
            ["<leader>sfp"] = { query = "@function.outer", desc = "Function with previous" },
            ["<leader>smp"] = { query = "@code_cell.outer", desc = "Code block with previous" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]a"] = { query = "@parameter.outer", desc = "Next argument (parameter) start" },
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]o"] = { query = "@class.outer", desc = "Next object (class) start" },
            ["]/"] = { query = "@comment.outer", desc = "Next comment start" },
            ["]z"] = { query = "@fold", desc = "Next fold start" },
            ["]m"] = { query = "@code_cell.inner", desc = "Next code block start" },
          },
          goto_next_end = {
            ["]A"] = { query = "@parameter.outer", desc = "Next argument (argument) end" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]O"] = { query = "@class.outer", desc = "Next object (class) end" },
            ["]?"] = { query = "@comment.outer", desc = "Next comment end" },
            ["]Z"] = { query = "@fold", desc = "Next fold end" },
            ["]M"] = { query = "@code_cell.inner", desc = "Next code block end" },
          },
          goto_previous_start = {
            ["[a"] = { query = "@parameter.outer", desc = "Prev argument (parameter) start" },
            ["[f"] = { query = "@function.outer", desc = "Prev function start" },
            ["[o"] = { query = "@class.outer", desc = "Prev class (object) start" },
            ["[/"] = { query = "@comment.outer", desc = "Prev comment start" },
            ["[z"] = { query = "@fold", desc = "Prev fold start" },
            ["[m"] = { query = "@code_cell.inner", desc = "Next code block start" },
          },
          goto_previous_end = {
            ["[D"] = { query = "@assignment.outer", desc = "Prev definition (assignment) end" },
            ["[A"] = { query = "@parameter.outer", desc = "Prev argument (parameter) end" },
            ["[F"] = { query = "@function.outer", desc = "Prev function end" },
            ["[J"] = { query = "@loop.outer", desc = "Prev loop end" },
            ["[?"] = { query = "@comment.outer", desc = "Prev comment end" },
            ["[Z"] = { query = "@fold", desc = "Prev fold end" },
            ["[M"] = { query = "@code_cell.inner", desc = "Next code block end" },
          },
        },
      },
    })
    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    local which_key = require("which-key")

    which_key.add({
      { "<leader>s",  group = " Swap groups" },
      { "<leader>sa", group = " Swap arguments (parameters)" },
      { "<leader>sf", group = " Swap functions" },
    })

    vim.treesitter.language.register('groovy', 'nextflow')
  end
}

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter.git",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git",
    version = "main",
  },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local languages = {
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "python",
  "bash",
  "dockerfile",
  "json",
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
  "regex",
  "markdown",
  "markdown_inline",
  "zig",
  "typst"
}

local ts = require('nvim-treesitter')

local available_languages = ts.get_available()

local missing_languages = {}

for _, language in pairs(languages) do
  if not vim.tbl_contains(available_languages, language) then
    table.insert(missing_languages, language)
  end
end

ts.install(missing_languages)

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup("treesitter.setup", {}),
  callback = function(args)
    local buf = args.buf
    local filetype = args.match

    local language = vim.treesitter.language.get_lang(filetype) or filetype

    if not vim.treesitter.language.add(language) then
      return
    end
    vim.treesitter.start(buf, language)
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})


require("nvim-treesitter-textobjects").setup({
  select = { enable = true, lookahead = true, }
})

local select = require("nvim-treesitter-textobjects.select").select_textobject

vim.keymap.set({ "x", "o" }, "aa", function() select("@parameter.outer") end,
  { desc = "Outer argument (parameter)" })
vim.keymap.set({ "x", "o" }, "ia", function() select("@parameter.inner") end,
  { desc = "Inner argument (parameter)" })

vim.keymap.set({ "x", "o" }, "af", function() select("@function.outer") end,
  { desc = "Outer function" })
vim.keymap.set({ "x", "o" }, "if", function() select("@function.inner") end,
  { desc = "Inner function" })

vim.keymap.set({ "x", "o" }, "ao", function() select("@class.outer") end,
  { desc = "Outer object (class)" })
vim.keymap.set({ "x", "o" }, "io", function() select("@class.inner") end,
  { desc = "Inner object (class)" })

vim.keymap.set({ "x", "o" }, "ao", function() select("@class.outer") end,
  { desc = "Outer object (class)" })
vim.keymap.set({ "x", "o" }, "io", function() select("@class.inner") end,
  { desc = "Inner object (class)" })

vim.keymap.set({ "x", "o" }, "au", function() select("@type.outer") end,
  { desc = "Outer type" })
vim.keymap.set({ "x", "o" }, "iu", function() select("@type.inner") end,
  { desc = "Inner type" })

vim.keymap.set({ "x", "o" }, "am", function() select("@code_cell.outer") end,
  { desc = "Outer code block" })
vim.keymap.set({ "x", "o" }, "im", function() select("@code_cell.inner") end,
  { desc = "Inner code block" })

local which_key = require("which-key")

which_key.add({
  { "<leader>s", group = "Treesitter swap" },
})

local swap_next = require("nvim-treesitter-textobjects.swap").swap_next

vim.keymap.set({ "n" }, "<leader>san", function() swap_next("@parameter.inner") end,
  { desc = "Argument (parameter) with next" })
vim.keymap.set({ "n" }, "<leader>sfn", function() swap_next("@function.outer") end,
  { desc = "Function with next" })
vim.keymap.set({ "n" }, "<leader>smn", function() swap_next("@code_cell.outer") end,
  { desc = "Code block with next" })

local swap_previous = require("nvim-treesitter-textobjects.swap").swap_previous

vim.keymap.set({ "n" }, "<leader>sap", function() swap_previous("@parameter.inner") end,
  { desc = "Argument (parameter) with previous" })
vim.keymap.set({ "n" }, "<leader>sfp", function() swap_previous("@function.outer") end,
  { desc = "Function with previous" })
vim.keymap.set({ "n" }, "<leader>smp", function() swap_previous("@code_cell.outer") end,
  { desc = "Code block with previous" })

local goto_next = require("nvim-treesitter-textobjects.move").goto_next

vim.keymap.set({ "n", "x", "o" }, "]a", function() goto_next("@parameter.outer", "textobjects") end,
  { desc = "Next argument (parameter)" })
vim.keymap.set({ "n", "x", "o" }, "]f", function() goto_next("@function.outer", "textobjects") end,
  { desc = "Next function" })
vim.keymap.set({ "n", "x", "o" }, "]o", function() goto_next("@object.outer", "textobjects") end,
  { desc = "Next object (class)" })
vim.keymap.set({ "n", "x", "o" }, "]m", function() goto_next("@code_cell.inner", "textobjects") end,
  { desc = "Next code block" })

local next_start = require("nvim-treesitter-textobjects.move").goto_next_start

vim.keymap.set({ "n", "x", "o" }, "]u", function() next_start("@type.inner", "textobjects") end,
  { desc = "Next type" })

local goto_previous = require("nvim-treesitter-textobjects.move").goto_previous

vim.keymap.set({ "n", "x", "o" }, "[a", function() goto_previous("@parameter.outer", "textobjects") end,
  { desc = "Previous argument (parameter)" })
vim.keymap.set({ "n", "x", "o" }, "[f", function() goto_previous("@function.outer", "textobjects") end,
  { desc = "Previous function start" })
vim.keymap.set({ "n", "x", "o" }, "[o", function() goto_previous("@object.outer", "textobjects") end,
  { desc = "Previous object (class)" })
vim.keymap.set({ "n", "x", "o" }, "[m", function() goto_previous("@code_cell.inner", "textobjects") end,
  { desc = "Previous Next code block" })

local previous_start = require("nvim-treesitter-textobjects.move").goto_previous_start

vim.keymap.set({ "n", "x", "o" }, "[u", function() previous_start("@type.inner", "textobjects") end,
  { desc = "Previous type" })

local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

require('treesitter-context').setup {
  enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false,     -- Enable multiwindow support.
  max_lines = 3,           -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 3,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 3, -- Maximum number of lines to show for a single context
  trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20,     -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

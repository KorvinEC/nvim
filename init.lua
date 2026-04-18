-- Build hooks for vim.pack plugins
-- Must be registered before any vim.pack.add() calls to catch install events
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end

    if name == "blink" then
      vim.notify("Building blink.cmp fuzzy matcher...", vim.log.levels.INFO)
      local result = vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
      if result.code == 0 then
        vim.notify("blink.cmp fuzzy matcher built successfully", vim.log.levels.INFO)
      else
        vim.notify("blink.cmp fuzzy matcher build failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
      end
    end

    if name == "molten-nvim" then
      vim.cmd("UpdateRemotePlugins")
    end
  end,
})

vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim"
})

local colorscheme_exists, _ = pcall(vim.cmd.colorscheme, "gruvbox")

if colorscheme_exists then
  vim.o.background = "dark"
  vim.cmd.colorscheme("gruvbox")
end

require("keymap")
require("options")
require("statusline")
require("undotree")
require("yank-highlight")
require("lsp")
require("lazygit")

require("plugins.snacks")
require("plugins.which-key")
require("plugins.treesitter")
require("plugins.oil")
require("plugins.mini")
require("plugins.autopairs")

-- luasnip should be loaded before blink
require("plugins.luasnip")
require("plugins.blink")

require("plugins.conform")
require("plugins.flash")
require("plugins.gitsigns")
require("plugins.highlight-colors")
require("plugins.indent")
require("plugins.surround")
require("plugins.smart-splits")
require("plugins.tabout")
require("plugins.todo-comment")
require("plugins.markdown")
require("plugins.csvview")
require("plugins.dbee")
require("plugins.molten")
require("plugins.agentic")
require("plugins.opencode")
require("plugins.quicker")

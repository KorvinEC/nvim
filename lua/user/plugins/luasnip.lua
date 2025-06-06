return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    { "rafamadriz/friendly-snippets" },
  },
  config = function()
    require("luasnip.loaders.from_lua").load({ paths = { "./snippets/lua/" } })
    require("luasnip.loaders.from_vscode").lazy_load({
      exclude = { "python" },
      paths = "./snippets/vs_code/"
    })

    local luasnip = require("luasnip")

    luasnip.setup({
      store_selection_keys = "<Tab>",
    })

    luasnip.filetype_extend("javascript", { "javascriptreact", "typescript", "typecriptreact" })
    luasnip.filetype_extend("typescript", { "javascript" })
    luasnip.filetype_extend("typescriptreact", { "javascript", "html" })
    luasnip.filetype_extend("javascriptreact", { "javascript", "html" })
    luasnip.filetype_extend("html", { "javascriptreact", "typecriptreact" })

    vim.keymap.set({ "i", "s" }, "<C-e>", function()
      if luasnip.choice_active() then
        vim.ui.select(
          luasnip.get_current_choices(),
          { prompt = 'Select', format_item = function(item) return item end, },
          function(_, index)
            luasnip.set_choice(index)
          end
        )
      end
    end, { silent = true })
  end
}

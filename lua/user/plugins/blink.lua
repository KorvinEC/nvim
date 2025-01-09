return {
  'saghen/blink.cmp',
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        { "rafamadriz/friendly-snippets" },
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local luasnip = require("luasnip")

        luasnip.filetype_extend("javascript", { "javascriptreact", "typescript", "typecriptreact" })
        luasnip.filetype_extend("typescript", { "javascript" })
        luasnip.filetype_extend("typescriptreact", { "javascript", "html" })
        luasnip.filetype_extend("javascriptreact", { "javascript", "html" })
        luasnip.filetype_extend("html", { "javascriptreact", "typecriptreact" })
      end
    },
  },
  version = '*',
  opts = {
    snippets = { preset = 'luasnip' },
    keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    sources = {
      default = { 'snippets', 'lsp', 'path', 'buffer' },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          columns = {
            { "label", "label_description", "kind_icon", "kind", gap = 1 },
          },
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = true
      },
    },
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" }
}

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
      ['<Tab>'] = {
        function(cmp)
          if not cmp.is_visible() and cmp.snippet_active() then
            return cmp.snippet_forward()
          end
          return cmp.select_next()
        end,
        'select_next',
        'fallback',
      },
      ['<S-Tab>'] = {
        function(cmp)
          if not cmp.is_visible() and cmp.snippet_active() then
            return cmp.snippet_backward()
          end
          return cmp.select_prev()
        end,
        'select_prev',
        'fallback',
      },

      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },
    sources = {
      default = { 'snippets', 'lsp', 'path', 'buffer' },
      providers = {
        lsp = {
          score_offset = 20,
        },
        snippets = {
          score_offset = 10,
          min_keyword_length = 1,
        },
        buffer = {
          min_keyword_length = 4,
        },
      }
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
            { "label",     "label_description", gap = 3 },
            { "kind_icon", "kind",              "source_name", gap = 1 }
          },
          treesitter = { "lsp" },
          components = {
            source_name = {
              width = { max = 30 },
              text = function(ctx) return ctx.source_name end,
              highlight = 'BlinkCmpLabel',
            },
          },
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
  opts_extend = { "sources.default" },
}

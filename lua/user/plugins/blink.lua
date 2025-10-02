--- TODO: add usage of trigger symbol, but need to investigate how to delete this symbol from input char
local trigger_symbol = { "@" }

---@type blink.cmp.SourceProviderConfigPartial
local lsp_config = {
  transform_items = function(context, items)
    local types = require('blink.cmp.types')
    for _, item in ipairs(items) do
      if item.kind == types.CompletionItemKind.Variable
          or item.kind == types.CompletionItemKind.EnumMember
      then
        item.score_offset = item.score_offset + 100
      end
    end
    return items
  end,
}

---@type blink.cmp.SourceProviderConfigPartial
local snippets_config = {
  -- should_show_items = function(context, _)
  --   return context.trigger.initial_kind ~= 'trigger_character'
  -- end
}

---@type blink.cmp.SourceProviderConfig
local spell_config = {
  name = 'Spell',
  module = 'blink-cmp-spell',
  opts = {
    -- EXAMPLE: Only enable source in `@spell` captures, and disable it
    -- in `@nospell` captures.
    enable_in_context = function()
      local curpos = vim.api.nvim_win_get_cursor(0)
      local captures = vim.treesitter.get_captures_at_pos(
        0,
        curpos[1] - 1,
        curpos[2] - 1
      )
      local in_spell_capture = false
      for _, cap in ipairs(captures) do
        if cap.capture == 'spell' then
          in_spell_capture = true
        elseif cap.capture == 'nospell' then
          return false
        end
      end
      return in_spell_capture
    end,
  },
}

---@type blink.cmp.CmdlineConfig
local cmdline_config = {
  sources = function()
    local type = vim.fn.getcmdtype()
    -- Search forward and backward
    if type == '/' or type == '?' then return { 'buffer' } end
    -- Commands
    if type == ':' or type == '@' then return { 'cmdline' } end
    return {}
  end,
  ---@type blink.cmp.KeymapConfig
  keymap = {
    preset = 'cmdline',
    ["<CR>"] = {
      function(cmp)
        if cmp.get_selected_item() then
          return cmp.select_and_accept()
        end
      end,
      'fallback'
    },
    ["<S-CR>"] = {
      function(cmp)
        if cmp.get_selected_item() then
          return cmp.select_accept_and_enter()
        end
      end,
      'fallback'
    }
  },
  completion = {
    menu = { auto_show = true },
    list = { selection = { preselect = false, auto_insert = true } }
  }
}

---@type blink.cmp.KeymapConfig
local keymap_config = {
  preset = 'default',
  ['<C-l>'] = { 'snippet_forward', 'fallback' },
  ['<C-h>'] = { 'snippet_backward', 'fallback' },

  ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
  ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
}

return {
  'saghen/blink.cmp',
  dependencies = {
    { "L3MON4D3/LuaSnip" },
    { 'ribru17/blink-cmp-spell' },
    { "williamboman/mason-lspconfig.nvim" },
    { "xzbdmw/colorful-menu.nvim", }
  },
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = {
        function(a, b)
          local sort = require('blink.cmp.fuzzy.sort')
          if a.source_id == 'spell' and b.source_id == 'spell' then
            return sort.label(a, b)
          end
        end,
        -- This is the normal default order, which we fall back to
        'score',
        'sort_text',
      },
      frecency = { enabled = true },
      use_proximity = true,
    },
    snippets = { preset = 'luasnip' },
    keymap = keymap_config,
    sources = {
      default = { 'lazydev', 'spell', 'lsp', 'buffer', 'snippets', 'path' },
      providers = {
        lsp = lsp_config,
        snippets = snippets_config,
        buffer = {
          min_keyword_length = function(context)
            if context.mode == "cmdline" then return 1 end
            return 4
          end
        },
        spell = spell_config,
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },

      },
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
          kind_resolution = nil,
          semantic_token_resolution = nil,
        },
      },
      menu = {
        draw = {
          columns = {
            { "kind_icon", "label",       gap = 1 },
            { "kind",      "source_name", gap = 1 }
          },
          treesitter = { "lsp" },
          components = {
            source_name = {
              width = { max = 30 },
              text = function(ctx) return ctx.source_name end,
              highlight = 'BlinkCmpLabel',
            },
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
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
    signature = { enabled = true },
    cmdline = cmdline_config,
  },
  opts_extend = { "sources.default" },
}

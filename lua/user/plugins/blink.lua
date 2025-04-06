---@type blink.cmp.SourceProviderConfig
local lsp_config = {
  transform_items = function(_, items)
    for _, item in ipairs(items) do
      if item.kind == require('blink.cmp.types').CompletionItemKind.Variable then
        item.score_offset = item.score_offset * 2
      end
    end
    return items
  end,
}

local trigger_text = "@"

--- NOTE: Taken from https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/blink-cmp.lua
---@type blink.cmp.SourceProviderConfig
local snippets_config = {
  min_keyword_length = 1,
  -- Only show snippets if I type the trigger_text characters, so
  -- to expand the "bash" snippet, if the trigger_text is "@" I have to
  should_show_items = function(_, _)
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
    -- NOTE: remember that `trigger_text` is modified at the top of the file
    return before_cursor:match(trigger_text .. "%w*$") ~= nil
  end,
  -- After accepting the completion, delete the trigger_text characters
  -- from the final inserted text
  -- Modified transform_items function based on suggestion by `synic` so
  -- that the luasnip source is not reloaded after each transformation
  -- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
  -- NOTE: I also tried to add the "@" prefix to all of the snippets loaded from
  -- friendly-snippets in the luasnip.lua file, but I was unable to do
  -- so, so I still have to use the transform_items here
  -- This removes the "@" only for the friendly-snippets snippets
  transform_items = function(_, items)
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local before_cursor = line:sub(1, col)
    local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
    if start_pos then
      for _, item in ipairs(items) do
        if not item.trigger_text_modified then
          ---@diagnostic disable-next-line: inject-field
          item.trigger_text_modified = true
          item.textEdit = {
            newText = item.insertText or item.label,
            range = {
              start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
              ["end"] = { line = vim.fn.line(".") - 1, character = end_pos + 0 },
            },
          }
        end
      end
    end
    return items
  end,
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


---@type blink.cmp.KeymapConfig
local keymap_config = {
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
}


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
    { 'ribru17/blink-cmp-spell' },
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
        'kind',
        'label',
      },
    },
    snippets = { preset = 'luasnip' },
    keymap = keymap_config,
    sources = {
      default = { 'spell', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = lsp_config,
        snippets = snippets_config,
        buffer = { min_keyword_length = 4 },
        spell = spell_config,
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

return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = {
                { "rafamadriz/friendly-snippets" },
            },
        },
        "onsails/lspkind.nvim"
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })

        local luasnip = require("luasnip")

        local lspkind = require('lspkind')

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<C-j>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
                ['<C-l>'] = cmp.mapping(function(fallback)
                    if luasnip.choice_active() then
                        luasnip.change_choice(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<C-h>'] = cmp.mapping(function(fallback)
                    if luasnip.choice_active() then
                        luasnip.change_choice(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-o>'] = cmp.mapping.open_docs(),
                ['<C-s>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() and cmp.get_active_entry() then
                                luasnip.expand()
                            else
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                            end
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp', max_item_count = 10 },
                { name = 'luasnip',  max_item_count = 10 },
                { name = 'buffer',   keyword_length = 5 },
                { name = 'path' },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text', -- show only symbol annotations
                    maxwidth = {
                        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        -- can also be a function to dynamically calculate max width such as
                        -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                        menu = 50,            -- leading text (labelDetails)
                        abbr = 50,            -- actual suggestion item
                    },
                    ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                    menu = {
                        buffer = "[buff]",
                        nvim_lsp = "[lsp]",
                        path = "[path]",
                        luasnip = "[snip]"
                    }
                })
            },
            experimental = { ghost_text = true }
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        luasnip.filetype_extend("javascript", { "javascriptreact", "typescript", "typecriptreact" })
        luasnip.filetype_extend("typescript", { "javascript" })
        luasnip.filetype_extend("typescriptreact", { "javascript", "html" })
        luasnip.filetype_extend("javascriptreact", { "javascript", "html" })
        luasnip.filetype_extend("html", { "javascriptreact", "typecriptreact" })
    end,
}

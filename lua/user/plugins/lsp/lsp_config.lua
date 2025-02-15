return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp" },
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "folke/which-key.nvim" },
  },
  config = function()
    local lspconfig = require("lspconfig")

    local mason_lspconfig = require("mason-lspconfig")

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[t", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]t", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        -- LSP functions

        keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Smart rename" })
        keymap.set("n", "<leader>lR", ":LspRestart<CR>", { desc = "Restart" })
        keymap.set("n", "<leader>li", ":LspInfo<CR>", { desc = "Info" })
        keymap.set("n", "<leader>lL", ":LspLog<CR>", { desc = "Log" })
        keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
        keymap.set("n", "<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Inlay hints toggle" })

        local which_key = require("which-key")

        which_key.add({
          { "<leader>l", group = " Lsp functions" }
        })
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local handlers = {
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
    }

    mason_lspconfig.setup_handlers(handlers)
  end
}

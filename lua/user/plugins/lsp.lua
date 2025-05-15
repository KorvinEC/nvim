return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
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
  },
  config = function()
    local mason = require("mason")

    mason.setup({})

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = {
        "basedpyright",
        "ruff",
        "lua_ls",
        "bashls",
        "html",
        "ts_ls",
        "eslint",
        "taplo",
        "dockerls",
        "jsonls",
        "rust_analyzer",
        "cssls",
        "tailwindcss",
        "clangd"
      },
    })

    ---@param client vim.lsp.Client
    ---@param bufnr boolean|integer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "Hover" })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show line diagnostics" })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
        { noremap = true, silent = true, buffer = bufnr, desc = "Signature help" })
      vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename,
        { noremap = true, silent = true, buffer = bufnr, desc = "Rename" })
      vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action,
        { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })
      vim.keymap.set("n", "<space>lf", function()
        vim.lsp.buf.format({ async = true })
      end, { noremap = true, silent = true, buffer = bufnr, desc = "Format" })

      vim.keymap.set("n", "<space>lR", function()
        vim.lsp.stop_client(vim.lsp.get_clients())
        vim.cmd("edit", bufnr)
      end, { buffer = bufnr, desc = "Restart" })
    end

    vim.lsp.config("*", {
      on_attach = on_attach
    })

    vim.api.nvim_create_augroup("LspSetup_Inlayhints", { clear = true })
    vim.cmd.highlight("default link LspInlayHint Comment")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = "LspSetup_Inlayhints",
      callback = function(args)
        if not (args.data and args.data.client_id) then
          return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then
          vim.notify_once("LSP inlay hints attached failed: nil client.", vim.log.levels.ERROR)
          return
        end

        if client.name == "zls" then
          vim.g.zig_fmt_autosave = 1
        end

        if client.server_capabilities.inlayHintProvider or client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end,
    })
  end,
}

---@param buffer_number integer
local lsp_restart = function(buffer_number)
  -- Store the buffer information before stopping clients
  local bufnr = buffer_number
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  -- We don't need filetype anymore since we're using BufEnter instead of FileType

  -- Get all clients attached to the buffer
  local clients = vim.lsp.get_clients({ buffer = buffer_number })
  local client_names = {}

  -- Store client names for later reattachment
  for _, client in ipairs(clients) do
    table.insert(client_names, client.name)
    vim.lsp.stop_client(client.id, true)
  end

  local timer = assert(vim.uv.new_timer())

  timer:start(500, 0, function()
    vim.schedule(function()
      -- Reload the current buffer
      vim.cmd("edit!")

      -- Force LSP reattachment for the current buffer
      if #client_names > 0 then
        vim.defer_fn(function()
          -- Trigger LSP attachment by emitting a BufEnter event
          vim.api.nvim_exec_autocmds("BufEnter", {
            buffer = bufnr,
          })

          -- For some LSP servers, we might need to manually trigger attachment
          for _, client_name in ipairs(client_names) do
            -- Try to restart the specific client for this buffer
            local ok, _ = pcall(function()
              vim.cmd("LspStart " .. client_name)
            end)

            if ok then
              vim.notify("Reattached " .. client_name .. " to " .. vim.fn.fnamemodify(bufname, ":t"),
                vim.log.levels.INFO)
            end
          end
        end, 100)
      end
    end)
  end)
end

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

    ---@param bufnr integer
    local on_attach = function(_, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "Hover" })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show line diagnostics" })
      vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help,
        { noremap = true, silent = true, buffer = bufnr, desc = "Signature help" })
      vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename,
        { noremap = true, silent = true, buffer = bufnr, desc = "Rename" })
      vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action,
        { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })
      vim.keymap.set("n", "<space>lf", function()
        vim.lsp.buf.format({ async = true })
      end, { noremap = true, silent = true, buffer = bufnr, desc = "Format" })

      vim.keymap.set("n", "<space>lR", function() lsp_restart(bufnr) end, { buffer = bufnr, desc = "Restart" })
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

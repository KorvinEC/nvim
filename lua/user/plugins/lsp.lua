vim.diagnostic.config({ virtual_text = { current_line = true } })

vim.lsp.enable("ruff")
vim.lsp.enable("ty")

vim.keymap.set('n', 'grK', function()
  vim.ui.select(
    {
      "Enable virtual lines",
      "Enable inline virtual lines",
      "Enable virtual text",
      "Enable inline virtual text",
      "Disable",
    },
    { prompt = "Select virtual text option" },
    function(choice)
      if choice == "Disable" then
        vim.diagnostic.config({
          virtual_lines = false,
          virtual_text = false
        })
      elseif choice == "Enable virtual lines" then
        vim.diagnostic.config({
          virtual_lines = true,
          virtual_text = false
        })
      elseif choice == "Enable virtual text" then
        vim.diagnostic.config({
          virtual_lines = false,
          virtual_text = true
        })
      elseif choice == "Enable inline virtual lines" then
        vim.diagnostic.config({
          virtual_lines = {
            current_line = true
          },
          virtual_text = false
        })
      elseif choice == "Enable inline virtual text" then
        vim.diagnostic.config({
          virtual_text = {
            current_line = true
          },
          virtual_lines = false
        })
      end
    end
  )
end, {
  desc = 'Enable or disable virtual text or lines'
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

    if client.server_capabilities.inlayHintProvider or client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    end

    vim.keymap.set("n", "grh", function()
      local buffer_number = vim.fn.bufnr()

      local inlay_hint_enabled = not vim.lsp.inlay_hint.is_enabled({ bufnr = buffer_number })

      vim.lsp.inlay_hint.enable(inlay_hint_enabled, { bufnr = buffer_number })

      local filename = vim.fn.fnamemodify(
        vim.fn.bufname(bufnr),
        ":t"
      )

      local messsage_string = inlay_hint_enabled and "enabled" or "disabled"

      vim.api.nvim_echo(
        {
          {
            string.format(
              "Inlay hints %s for [%d] %s",
              messsage_string,
              bufnr,
              filename
            )
          }
        },
        true,
        {}
      )
    end, { desc = "Toggle inlay hints" })

    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("LspCodelens", { clear = true }),
      callback = function(args)
        vim.lsp.codelens.refresh()
        local lenses = vim.lsp.codelens.get(args.buf)

        vim.notify(
          string.format(
            "Available lenses: %s",
            vim.inspect(lenses)
          )
        )
      end,
    })
  end,
})

return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

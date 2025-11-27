vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")

vim.diagnostic.config({ virtual_text = { current_line = true } })

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
end, { desc = 'Enable or disable virtual text or lines' })

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
      vim.notify("Inlay hints enabled")
    end

    vim.keymap.set("n", "grh", function()
      local inlay_hint_enabled = not vim.lsp.inlay_hint.is_enabled()

      vim.lsp.inlay_hint.enable(inlay_hint_enabled)
      vim.notify(inlay_hint_enabled and "Inlay hints enabled" or "Inlay hints disasbled")
    end, { desc = "Toggle inlay hints" })
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

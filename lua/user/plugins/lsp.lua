vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")

vim.diagnostic.config({ virtual_text = true })

vim.keymap.set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({
    virtual_lines = new_config,
    virtual_text = not new_config
  })
end, { desc = 'Change diagnostic virtual_lines to virtual_text' })

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

vim.opt.undofile = true

vim.cmd("packadd nvim.undotree")

vim.keymap.set("n", "<leader>u", "<cmd>Undotree<CR>", { desc = "Open undotree" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nvim-undotree",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>Undotree<CR>", { buffer = true })
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    if vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "nvim-undotree"
        and vim.fn.winnr("$") == 1 then
      vim.cmd("quit")
    end
  end
})

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Override for frontend development filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"javascript", "javascriptreact","typescript", "typescriptreact", "html", "css", "json"},
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})

opt.clipboard = "unnamedplus"

opt.hlsearch = true
opt.incsearch = true

opt.scrolloff = 4

opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"

vim.filetype.add {
    pattern = {
        [".*%.nf"] = "nf"
    }
}

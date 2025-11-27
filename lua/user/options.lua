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
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "json" },
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

opt.clipboard = "unnamedplus"

local kernel_name_release = vim.fn.system { 'uname', '--kernel-name', '--kernel-release' }
if kernel_name_release:find("Linux") and kernel_name_release:find("WSL") then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

opt.hlsearch = true
opt.incsearch = true

opt.scrolloff = 4

opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"

vim.filetype.add {
  pattern = {
    [".*%.nf"] = "nextflow"
  }
}

opt.spelllang = "en"
opt.spell = true
opt.spelloptions = "camel"

opt.iskeyword:remove { ".", "_" }

-- Save folds between files
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = vim.api.nvim_create_augroup("RememberFolds", { clear = true }),
  command = "mkview",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("RememberFolds", { clear = true }),
  command = "silent! loadview",
})

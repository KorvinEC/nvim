vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>ol", vim.pack.update, { desc = "Open VimPack update" })
keymap.set("n", "<leader>ot", "<cmd>terminal<CR>", { desc = "Open terminal" })

keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Write file" })
keymap.set("n", "<leader>W", "<cmd>write!<CR>", { desc = "Force write file" })

keymap.set('n', 'gl', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-l><CR>', { desc = "Refresh screen" })

keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
keymap.set("n", "<leader>Q", "<cmd>quit!<CR>", { desc = "Force quit" })

keymap.set("t", "<C-Q>", "<C-\\><C-n>", { desc = "Exit from terminal" })

local quickfix_list_function = function()
  local windows = vim.fn.getwininfo()

  for _, win in ipairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end

  vim.cmd.copen()
end

local loclist_function = function()
  local windows = vim.fn.getwininfo()

  for _, win in ipairs(windows) do
    if win["loclist"] == 1 then
      vim.cmd.lclose()
      return
    end
  end

  vim.cmd.lopen()
end

keymap.set("n", "<leader>e", quickfix_list_function, { desc = "Open quickfix list" })
keymap.set("n", "<leader>c", loclist_function, { desc = "Open location list" })

keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Open diagnostics in location list" })

local function get_make_arguments()
  vim.ui.input(
    { prompt = "make program arugments" },
    function(input)
      if input == nil then return end

      vim.cmd("make " .. input)
    end
  )
end

keymap.set("n", "<leader>R", get_make_arguments, { desc = "Run make program" })

vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("File path: ", path)
end, { desc = "Copy file full path" })

vim.keymap.set("n", "<leader>yn", function()
  local path = vim.fn.expand("%:t")
  vim.fn.setreg("+", path)
  print("File name: ", path)
end, { desc = "Copy file name" })

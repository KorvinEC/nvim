vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>ol", "<cmd>Lazy<CR>", { desc = "Open Lazy" })
keymap.set("n", "<leader>om", "<cmd>Mason<CR>", { desc = "Open Mason" })
keymap.set("n", "<leader>ot", "<cmd>terminal<CR>", { desc = "Open terminal" })

keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Write file" })
keymap.set("n", "<leader>W", "<cmd>write!<CR>", { desc = "Force write file" })

keymap.set('n', 'gl', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-l><CR>', { desc = "Refresh screen" })

keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
keymap.set("n", "<leader>Q", "<cmd>quit!<CR>", { desc = "Force quit" })

keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Exit from terminal" })

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
      vim.cmd("make " .. input)
    end
  )
end

keymap.set("n", "<leader>r", get_make_arguments, { desc = "Run make program" })

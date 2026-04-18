local function spawn_lazygit()
  local previous_buffer = vim.api.nvim_get_current_buf()
  local current_window = vim.api.nvim_get_current_win()
  local buffer = vim.api.nvim_create_buf(true, false)

  vim.api.nvim_win_set_buf(current_window, buffer)

  vim.bo[buffer].buflisted = true
  vim.bo[buffer].bufhidden = "wipe"
  vim.bo[buffer].swapfile = false

  vim.fn.jobstart({ "lazygit" }, {
    term = true,
    on_exit = function()
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(previous_buffer) and vim.api.nvim_win_is_valid(current_window) then
          vim.api.nvim_win_set_buf(current_window, previous_buffer)
        end

        if vim.api.nvim_buf_is_valid(buffer) then
          vim.api.nvim_buf_delete(buffer, { force = true })
        end
      end)
    end,
  })

  if vim.api.nvim_buf_is_valid(buffer) then
    vim.bo[buffer].filetype = "lazygit"
  end

  vim.cmd.startinsert()
end

vim.keymap.set(
  "n",
  "<leader>og",
  spawn_lazygit,
  { desc = "Open Lazygit" }
)

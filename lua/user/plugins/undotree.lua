return {
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>ou", vim.cmd.UndotreeToggle, { desc = "Open undotree"})
    end
}

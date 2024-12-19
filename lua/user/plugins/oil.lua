return {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function ()
        require("oil").setup()
        vim.keymap.set("n", "<leader>t", "<cmd>Oil<CR>")
    end
}
